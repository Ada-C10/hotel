require_relative 'spec_helper'

describe 'BookingSystem class' do

  let (:today) { Date.today }
  let (:res1_checkout) { today + 3 }
  let (:res2_checkout) { today + 7}
  let (:today_minus_2) {today - 2}

  let (:reservation1) {
    check_in = today
    check_out = check_in + 3
    Hotel::Reservation.new(Hotel::DateRange.new(check_in, check_out), 1)
  }

  let (:reservation2) {
    check_in = today + 2
    check_out = check_in + 5
    Hotel::Reservation.new(Hotel::DateRange.new(check_in, check_out), 2)
  }

  let (:hotel_booker) {
    Hotel::BookingSystem.new(all_reservations: [reservation1, reservation2])
  }

  describe 'BookingSystem instantiation' do
    it 'creates an instance of BookingSystem class' do
      expect(Hotel::BookingSystem.new).must_be_instance_of Hotel::BookingSystem
      expect(hotel_booker).must_respond_to :all_rooms
      expect(hotel_booker).must_respond_to :all_reservations
      expect(hotel_booker).must_respond_to :all_room_blocks
    end

    it 'creates an instance of BookingSystem class with reservations as input'do
      expect(hotel_booker).must_be_instance_of Hotel::BookingSystem
    end

    it 'if reservations passed in, it stores all reservations in an array of Reservations' do
      hotel_booker.all_reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe 'list_rooms method' do
    it 'returns a formatted string of all the rooms' do
      expect(hotel_booker.list_rooms).must_be_instance_of String
    end
  end

  describe 'list_printable_available_rooms method' do
    it 'returns a formatted string of all the available rooms' do
      available_rooms = hotel_booker.list_printable_available_rooms(today, today + 7)
      expect(available_rooms).must_be_instance_of String
    end
  end

  describe 'list_available_rooms helper method' do

    let (:captures_both_res_dates) { Hotel::DateRange.new(today, res2_checkout)}

    let (:overlap_res_1) {Hotel::DateRange.new(today, today + 1)}
    let (:overlap_res_2) { Hotel::DateRange.new(res1_checkout, res2_checkout) }

    let (:before_dates) { Hotel::DateRange.new(today_minus_2 - 1, today_minus_2) }
    let (:after_dates) { Hotel::DateRange.new(res2_checkout, res2_checkout + 2) }

    it 'returns an array containing a list of available room numbers for a given date range' do
      expect(hotel_booker.list_available_rooms(captures_both_res_dates)).must_be_instance_of Array
    end

    it 'correctly identifies the list of available room numbers for a given date range' do
      all_rooms = [*1..20]
      all_but_room1 = [*2..20]
      all_but_room2 = [1, *3..20]
      all_other_rooms = [*3..20]

      expect(hotel_booker.list_available_rooms(captures_both_res_dates)).must_equal all_other_rooms
      expect(hotel_booker.list_available_rooms(overlap_res_1)).must_equal all_but_room1
      expect(hotel_booker.list_available_rooms(overlap_res_2)).must_equal all_but_room2

      expect(hotel_booker.list_available_rooms(before_dates)).must_equal all_rooms
      expect(hotel_booker.list_available_rooms(after_dates)).must_equal all_rooms
    end

    it 'correctly identifies the list of available room numbers for a given date range when there is an existing block' do

      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)

      expect(hotel_booker.list_available_rooms(Hotel::DateRange.new(today + 2, today + 7))).must_equal [*8..20]
    end

    it 'raises an error if given a check-out date occuring after a check-in date' do
      expect{hotel_booker.list_available_rooms(today + 1, today)}.must_raise ArgumentError
    end
  end

  describe 'list_unavailable_rooms helper method' do

    let (:captures_both_res_dates) { Hotel::DateRange.new(today, res2_checkout)}

    let (:overlap_res_1) {Hotel::DateRange.new(today, today + 1)}
    let (:overlap_res_2) { Hotel::DateRange.new(res1_checkout, res2_checkout) }

    let (:before_dates) { Hotel::DateRange.new(today_minus_2 - 1, today_minus_2) }
    let (:after_dates) { Hotel::DateRange.new(res2_checkout, res2_checkout + 2) }

    it 'returns an array containing a list of unavailable room numbers for a given date range' do
      expect(hotel_booker.list_available_rooms(Hotel::DateRange.new(today + 2, today + 4))).must_be_instance_of Array
    end

    it 'correctly identifies the list of unavailable room numbers for a given date range' do

      room_1 = [1]
      room_2 = [2]
      both_rooms = room_1 + room_2

      expect(hotel_booker.list_unavailable_rooms(captures_both_res_dates)).must_equal both_rooms
      expect(hotel_booker.list_unavailable_rooms(overlap_res_1)).must_equal room_1
      expect(hotel_booker.list_unavailable_rooms(overlap_res_2)).must_equal room_2

      expect(hotel_booker.list_unavailable_rooms(before_dates)).must_equal []
      expect(hotel_booker.list_unavailable_rooms(after_dates)).must_equal []

    end

    it 'correctly identifies the list of unavailable room numbers for a given date range when there is an existing block' do

      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)

      expect(hotel_booker.list_unavailable_rooms(Hotel::DateRange.new(today + 2, today + 7))).must_equal [*1..7]
    end
  end

  describe 'list_reservations_by_date method' do
    it 'returns a list of all reservations for a given date ' do
      matched_reservation = hotel_booker.list_reservations_by_date(today + 2)

      matched_reservation.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end

      expect(matched_reservation.length).must_equal 2

      matched_reservation_2 = hotel_booker.list_reservations_by_date(today + 1)

      expect(matched_reservation_2[0].room_num).must_equal 1
    end

    it 'returns an empty array if no reservations match a given date' do
      matched_reservation = hotel_booker.list_reservations_by_date(today + 10)
      expect(matched_reservation).must_be_instance_of Array
      expect(matched_reservation.length).must_equal 0
    end
  end

  describe 'make_reservation helper method' do

    let (:room_block) {
      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)
    }
    let (:room_block_2) {
      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)
    }

    it 'returns an instance of reservation' do
      expect(hotel_booker.make_reservation(Hotel::DateRange.new(today + 1, today + 4), 3)).must_be_instance_of Hotel::Reservation
    end

    it 'adds standard reservation to the list of all_reservations' do
      num_of_reservations = hotel_booker.all_reservations.length
      reservation = hotel_booker.make_reservation(Hotel::DateRange.new(today + 1, today + 4), 3)

      expect(hotel_booker.all_reservations.length - 1).must_equal num_of_reservations
      expect(hotel_booker.all_reservations[2]).must_equal reservation

    end

    it 'raises an error if room is unavailable' do
      expect{
        hotel_booker.make_reservation(today + 1, today + 4, 1)
      }.must_raise StandardError

    end

    it 'raises an error if normal booking tries to reserve a room in a block' do
      room_block
      expect{hotel_booker.make_reservation(Hotel::DateRange.new(today, res2_checkout), 3)}.must_raise StandardError
    end

    it 'raises an error if trying to reserve a room in a different block' do
      room_block
      room_block_2

      expect{hotel_booker.make_reservation(Hotel::DateRange.new(today, res2_checkout), 8, block: room_block)}.must_raise StandardError
    end

    it 'adds the reservation to the block\'s block_reservations' do
      num_block_reservations = room_block.block_reservations.length
      reservation = hotel_booker.make_reservation(Hotel::DateRange.new(today + 2, res2_checkout), 3, block: room_block)
      new_num_block_reservations = room_block.block_reservations.length

      expect(room_block.block_reservations.last).must_equal reservation
      expect(new_num_block_reservations - 1).must_equal num_block_reservations
    end

  end

  describe 'reserve_standard_room method' do
    it 'returns a reservation of a standard room if rooms available' do
      expect(hotel_booker.reserve_standard_room(today + 2, today + 7)).must_be_instance_of Hotel::Reservation
    end

    it 'uses the DateRange class to check for valid Date input' do
      expect{hotel_booker.reserve_standard_room(today, today - 1)}.must_raise ArgumentError
      expect{hotel_booker.reserve_standard_room('String of a Date' , today)}.must_raise ArgumentError
    end

    it 'raises an exception if no rooms are available for that date range' do
      20.times do
        hotel_booker.reserve_standard_room(today + 7, today + 8)
      end
      expect{hotel_booker.reserve_standard_room}.must_raise StandardError
    end

  end

  describe 'reserve_a_room_in_block' do

    let (:room_block) {
      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)
    }

    it 'returns a reservation of a room within the room block' do
      room_block
      expect(hotel_booker.all_room_blocks[0].block_id).must_equal 1
      expect(hotel_booker.reserve_a_room_in_block(1)).must_be_instance_of Hotel::Reservation
    end

    it 'raises an error if the block is not found' do
      expect{hotel_booker.reserve_a_room_in_block(2)}.must_raise ArgumentError
    end

    it 'raises an error if the given block has no availability' do
      room_block
      5.times do
        hotel_booker.reserve_a_room_in_block(1)
      end

      expect{hotel_booker.reserve_a_room_in_block(1)}.must_raise ArgumentError
    end
  end

  describe 'create_a_block method' do

    let (:room_block) {
      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)
    }
    let (:room_block_2) {
      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)
    }

    it 'returns a RoomBlock object if given valid parameters' do
      expect(room_block).must_be_instance_of Hotel::Block
    end

    it 'returns a RoomBlock with only available rooms for that time range' do
      expect(room_block.blocked_rooms).must_equal [*3..7]
    end

    it 'adds a RoomBlock to all_room_blocks list' do
      num_old_blocks = hotel_booker.all_room_blocks.length
      room_block
      num_new_blocks = hotel_booker.all_room_blocks.length

      expect(num_new_blocks - 1).must_equal num_old_blocks
      expect(hotel_booker.all_room_blocks[0]).must_equal room_block
    end

    it 'creates a block with blocked_rooms that do not include other blocked_rooms from other blocks' do

      room_block

      expect(room_block_2.blocked_rooms).must_equal [*8..12]
    end

  end

  describe 'is_room_available helper method' do

    let (:room_block) {
      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)
    }

    it 'returns true if room is available for the given date range' do
      expect(hotel_booker.is_room_available(Hotel::DateRange.new(today, today + 2), 2)).must_equal true
      expect(hotel_booker.is_room_available(Hotel::DateRange.new(today + 4, today + 5), 1)).must_equal true
    end

    it 'returns false if room is unavailable for the given date range' do
      expect(hotel_booker.is_room_available(Hotel::DateRange.new(today, today + 2), 1)).must_equal false
      expect(hotel_booker.is_room_available(Hotel::DateRange.new(today + 4, today + 5), 2)).must_equal false
    end

    it 'raises an exception if no rooms are available for that date range' do
      18.times do
        hotel_booker.reserve_standard_room(today + 1, today + 4)
      end

      expect{room_block}.must_raise StandardError
    end

    it 'raises an exception if not enough rooms are available for that date range' do
      14.times do
        hotel_booker.reserve_standard_room(today + 1, today + 4)

      end
      expect{room_block}.must_raise StandardError
    end
  end

  describe 'check_id method' do
    it 'raises an error if ID is blank' do
      expect{hotel_booker.check_id(' ')}.must_raise ArgumentError
      expect{hotel_booker.check_id(nil)}.must_raise ArgumentError
    end

    it 'raises an error if ID is less or equal to 0' do
      expect{hotel_booker.check_id(0)}.must_raise ArgumentError
      expect{hotel_booker.check_id(-1)}.must_raise ArgumentError
    end
  end

  describe 'find_block method' do

    let (:room_block) {
      hotel_booker.create_a_block(today + 2, today + 7, 5, 150)
    }

    it 'returns an instance of Block if the given id corresponds to a Block instance' do
      room_block
      expect(hotel_booker.find_block(1)).must_be_instance_of Hotel::Block
    end

    it 'returns the corresponding Block object if it corresponds to the given id' do
      room_block
      expect(hotel_booker.find_block(1)).must_equal room_block
    end

    it 'returns nil if block is not found' do
      expect(hotel_booker.find_block(1)).must_equal nil
    end

  end


end
