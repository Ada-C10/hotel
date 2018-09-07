require_relative 'spec_helper'

describe 'HotelBooker class' do

  let (:reservation1) {
    check_in = Date.today + 1
    check_out = check_in + 3
    Hotel::Reservation.new(check_in, check_out, 1)
  }

  let (:reservation2) {
    check_in = Date.today + 2
    check_out = check_in + 5
    Hotel::Reservation.new(check_in, check_out, 2)
  }

  let (:hotel_booker) {
    Hotel::HotelBooker.new(all_reservations: [reservation1, reservation2])
  }

  describe 'HotelBooker instantiation' do
    it 'creates an instance of HotelBooker class' do
      expect(Hotel::HotelBooker.new).must_be_instance_of Hotel::HotelBooker
    end

    it 'creates an instance of HotelBooker class with reservations as input'do
      expect(hotel_booker).must_be_instance_of Hotel::HotelBooker
    end

    it 'if reservations passed in, it stores all reservations in an array of Reservations' do
      hotel_booker.all_reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe 'get_printable_all_rooms method' do
    it 'returns a formatted string of all the rooms' do
      expect(hotel_booker.get_printable_all_rooms).must_be_instance_of String
    end
  end

  describe 'get_printable_available_rooms method' do
    it 'returns a formatted string of all the available rooms' do
      available_rooms = hotel_booker.get_printable_available_rooms(Date.today, Date.today + 7)
      expect(available_rooms).must_be_instance_of String
    end
  end

  describe 'reserve_a_room method' do

    it 'returns an instance of reservation' do
      expect(hotel_booker.reserve_a_room(Date.today + 1, Date.today + 4, 3)).must_be_instance_of Hotel::Reservation
    end

    it 'raises an error when given invalid dates' do
      expect{hotel_booker.reserve_a_room(Date.today + 1, Date.today - 4, 1)}.must_raise ArgumentError
    end

    it 'adds the reservation to the list of all_reservations' do
      num_of_reservations = hotel_booker.all_reservations.length
      reservation = hotel_booker.reserve_a_room(Date.today + 1, Date.today + 4, 3)

      expect(hotel_booker.all_reservations.length - 1).must_equal num_of_reservations
      expect(hotel_booker.all_reservations[2]).must_equal reservation

    end

    it 'raises an error if room is unavailable' do
      # [*3..20].each do |room|
      #   hotel_booker.reserve_a_room(Date.today + 1, Date.today + 4, room)
      # end
      expect{
        hotel_booker.reserve_a_room(Date.today + 1, Date.today + 4, 1)
      }.must_raise StandardError

    end

    it 'reserves the first available room for the given date range' do
      skip
      expect(hotel_booker.reserve_a_room(Date.today + 1, Date.today + 2).room_num).must_equal 2
      expect(hotel_booker.reserve_a_room(Date.today + 1, Date.today + 9).room_num).must_equal 3
    end
  end

  describe 'is_room_available helper method' do
    it 'returns true if room is available for the given date range' do
      expect(hotel_booker.is_room_available(Date.today, Date.today + 2, 2)).must_equal true
      expect(hotel_booker.is_room_available(Date.today + 4, Date.today + 5, 1)).must_equal true
    end

    it 'returns false if room is unavailable for the given date range' do
      expect(hotel_booker.is_room_available(Date.today, Date.today + 2, 1)).must_equal false
      expect(hotel_booker.is_room_available(Date.today + 4, Date.today + 5, 2)).must_equal false
    end
  end

  describe 'get_occupied_rooms helper method' do
    it 'returns an array containing a list of rooms' do
      reservations = [reservation1, reservation2]
      expect(hotel_booker.get_occupied_rooms(reservations)).must_equal [1, 2]
      expect(hotel_booker.get_occupied_rooms([reservation1])).must_equal [1]
      expect(hotel_booker.get_occupied_rooms([reservation2])).must_equal [2]
    end
  end

  describe 'get_reservations_by_date method' do
    it 'returns a list of all reservations for a given date ' do
      matched_reservation = hotel_booker.get_reservations_by_date(Date.today + 2)

      matched_reservation.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end

      expect(matched_reservation.length).must_equal 2

      matched_reservation_2 = hotel_booker.get_reservations_by_date(Date.today + 1)

      expect(matched_reservation_2[0].room_num).must_equal 1
    end

    it 'returns an empty array if no reservations match a given date' do
      matched_reservation = hotel_booker.get_reservations_by_date(Date.today + 10)
      expect(matched_reservation).must_be_instance_of Array
      expect(matched_reservation.length).must_equal 0
    end
  end

  describe 'list_unavailable_rooms method' do
    it 'returns an array containing a list of unavailable room numbers for a given date range' do
      expect(hotel_booker.list_available_rooms(Date.today + 2, Date.today + 4)).must_be_instance_of Array
    end

    it 'correctly identifies the list of unavailable room numbers for a given date range' do
      room_1 = [1]
      room_2 = [2]
      both_rooms = room_1 + room_2

      # Two date ranges *do* overlap if range A compared to range B:
      # - Same dates
      expect(hotel_booker.list_unavailable_rooms(Date.today + 1, Date.today + 7)).must_equal both_rooms
      # - Overlaps in the front
      expect(hotel_booker.list_unavailable_rooms(Date.today, Date.today + 2)).must_equal room_1
      # - Overlaps in the back
      expect(hotel_booker.list_unavailable_rooms(Date.today + 5, Date.today + 7)).must_equal room_2
      # - Completely contained
      expect(hotel_booker.list_unavailable_rooms(Date.today + 2, Date.today + 6)).must_equal both_rooms
      # - Completely containing
      expect(hotel_booker.list_unavailable_rooms(Date.today, Date.today + 8)).must_equal both_rooms
      #
      # Two date ranges are *not* overlapping if range A compared to range B:
      # - Completely before
      expect(hotel_booker.list_unavailable_rooms(Date.today - 1, Date.today)).must_equal []
      # - Completely after
      expect(hotel_booker.list_unavailable_rooms(Date.today + 8, Date.today + 9)).must_equal []
      # - Ends on the checkin date
      expect(hotel_booker.list_unavailable_rooms(Date.today, Date.today + 2)).must_equal room_1
      # - Starts on the checkout date (edited)
      expect(hotel_booker.list_unavailable_rooms(Date.today + 4, Date.today + 5)).must_equal room_2


      expect(hotel_booker.list_unavailable_rooms(Date.today + 2, Date.today + 3)).must_equal both_rooms

      expect(hotel_booker.list_unavailable_rooms(Date.today + 7, Date.today + 8)).must_equal []

    end

    it 'correctly identifies the list of unavailable room numbers for a given date range when there is an existing block' do

      puts hotel_booker.create_a_block(Date.today + 2, Date.today + 7, 5, 150)

      expect(hotel_booker.list_unavailable_rooms(Date.today + 2, Date.today + 7)).must_equal [*1..7]
    end
  end

  describe 'list_available_rooms method' do
    it 'returns an array containing a list of available room numbers for a given date range' do
      expect(hotel_booker.list_available_rooms(Date.today + 2, Date.today + 4)).must_be_instance_of Array
    end

    it 'correctly identifies the list of available room numbers for a given date range' do
      all_rooms = [*1..20]
      available_rooms = [*3..20]
      # date_range_1 = Hotel::DateRange.new(Date.today + 2, Date.today + 3)
      # date_range_2 = Hotel::DateRange.new(Date.today + 7, Date.today + 8)

      # Two date ranges *do* overlap if range A compared to range B:
      # - Same dates
      expect(hotel_booker.list_available_rooms(Date.today + 1, Date.today + 7)).must_equal available_rooms
      # - Overlaps in the front
      expect(hotel_booker.list_available_rooms(Date.today, Date.today + 2)).must_equal [*2..20]
      # - Overlaps in the back
      expect(hotel_booker.list_available_rooms(Date.today + 5, Date.today + 7)).must_equal [1,*3..20]
      # - Completely contained
      expect(hotel_booker.list_available_rooms(Date.today + 2, Date.today + 6)).must_equal available_rooms
      # - Completely containing
      expect(hotel_booker.list_available_rooms(Date.today, Date.today + 8)).must_equal available_rooms
      #
      # Two date ranges are *not* overlapping if range A compared to range B:
      # - Completely before
      expect(hotel_booker.list_available_rooms(Date.today - 1, Date.today)).must_equal all_rooms
      # - Completely after
      expect(hotel_booker.list_available_rooms(Date.today + 8, Date.today + 9)).must_equal all_rooms
      # - Ends on the checkin date
      expect(hotel_booker.list_available_rooms(Date.today, Date.today + 2)).must_equal [*2..20]
      # - Starts on the checkout date (edited)
      expect(hotel_booker.list_available_rooms(Date.today + 4, Date.today + 5)).must_equal [1,*3..20]


      expect(hotel_booker.list_available_rooms(Date.today + 2, Date.today + 3)).must_equal available_rooms

      expect(hotel_booker.list_available_rooms(Date.today + 7, Date.today + 8)).must_equal all_rooms
    end


    it 'correctly identifies the list of available room numbers for a given date range when there is an existing block' do

      puts hotel_booker.create_a_block(Date.today + 2, Date.today + 7, 5, 150)

      expect(hotel_booker.list_available_rooms(Date.today + 2, Date.today + 7)).must_equal [*8..20]
    end

    it 'raises an error if not given a Date' do
      expect{hotel_booker.list_available_rooms("Not a Date", Date.today)}.must_raise ArgumentError
      expect{hotel_booker.list_available_rooms(Date.today, "Also not a Date")}.must_raise ArgumentError
    end

    it 'raises an error if given a check-out date occuring after a check-in date' do
      expect{hotel_booker.list_available_rooms(Date.today + 1, Date.today)}.must_raise ArgumentError
    end

  end

  describe 'reserve_a_room_in_block' do
    before do
      @room_block = hotel_booker.create_a_block(Date.today + 2, Date.today + 7, 5, 150)
    end

    it 'returns a reservation of a room within the room block' do

      expect(hotel_booker.all_room_blocks[0].block_id).must_equal 1
      expect(hotel_booker.reserve_a_room_in_block(1)).must_be_instance_of Hotel::Reservation

      # @room_block.

    end

  end

  describe 'create_a_block method' do
    let (:room_block) {
      hotel_booker.create_a_block(Date.today + 2, Date.today + 7, 5, 150)
    }
    let (:room_block_2) {
      hotel_booker.create_a_block(Date.today + 2, Date.today + 7, 5, 150)
    }
    it 'returns a RoomBlock object if given valid parameters' do
      expect(room_block).must_be_instance_of Hotel::RoomBlock
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

    it 'raises an exception if no rooms are available for that date range' do
      [*3..20].each do |room|
        hotel_booker.reserve_a_room(Date.today + 1, Date.today + 4, room)
      end

      expect{room_block}.must_raise StandardError

    end
    it 'raises an exception if not enough rooms are available for that date range' do
      [*7..20].each do |room|
        hotel_booker.reserve_a_room(Date.today + 1, Date.today + 4, room)
      end

      expect{room_block}.must_raise StandardError

    end

    it 'creates a block with blocked_rooms that do not include other blocked_rooms from other blocks' do

      room_block

      expect(room_block_2.blocked_rooms).must_equal [*8..12]
    end

  end

  # describe 'is_Date method' do
  #   it 'returns true if given date is not a Date' do
  #     expect(is_Date(Date.today)).must_equal true
  #     expect(is_Date(Date.parse("2001-10-10"))).must_equal true
  #   end
  # end
end
