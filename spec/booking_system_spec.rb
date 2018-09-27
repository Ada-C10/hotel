require_relative 'spec_helper'
require 'pry'

describe 'BookingSystem class' do
  before do
    @booking = BookingSystem.new
    @booking.reserve_room("Oct 4 2018", "Oct 7 2018")
    @booking.create_block_of_rooms("Dec 1 2018", "Dec 5 2018", 180)
  end

  let (:overlap_before) {
    check_in = "Oct 3 2018"
    check_out = "Oct 6 2018"
    @booking.reserve_room(check_in, check_out)
  }

  let (:overlap_after) {
    check_in = "Oct 5 2018"
    check_out = "Oct 8 2018"
    @booking.reserve_room(check_in, check_out)
  }

  let (:contained_in_range) {
    check_in = "Oct 5 2018"
    check_out = "Oct 6 2018"
    @booking.reserve_room(check_in, check_out)
  }

  let (:no_overlap_before) {
    check_in = "Sep 4 2018"
    check_out = "Sep 7 2018"
    @booking.reserve_room(check_in, check_out)
  }

  let (:no_overlap_after) {
    check_in = "Nov 4 2018"
    check_out = "Nov 7 2018"
    @booking.reserve_room(check_in, check_out)
  }

  let (:end_on_checkin) {
    check_in = "Oct 1 2018"
    check_out = "Oct 4 2018"
    @booking.reserve_room(check_in, check_out)
  }

  let (:starts_on_checkout) {
    check_in = "Oct 7 2018"
    check_out = "Oct 10 2018"
    @booking.reserve_room(check_in, check_out)
  }

  let (:overlap_block) {
    check_in = "Dec 1 2018"
    check_out = "Dec 3 2018"
    @booking.reserve_room(check_in, check_out)
  }


  describe 'Initializer' do
    it 'is an instance of BookingSystem' do
      expect(@booking).must_be_kind_of BookingSystem
    end

    it 'loads an array of rooms' do
      expect(@booking.rooms).must_be_kind_of Array
    end

  end

  describe 'load_rooms' do
    it 'is an array of room numbers' do
      expect(@booking.rooms.first).must_be_kind_of Integer
    end
  end

  describe 'list_all_rooms' do
    it 'returns a list of all the rooms in the hotel' do
      expect(@booking.list_all_rooms).must_be_kind_of Array
      expect(@booking.list_all_rooms.count).must_equal 20
    end
  end

  describe 'reserve_room' do
    it 'adds a new reservation to the list of reservations' do
      before_res = @booking.reservations.count
      overlap_before

      expect(@booking.reservations.count).must_equal before_res + 1
    end

    it "selects the next room when requested date overlaps" do
      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }
      room3_reservations = @booking.reservations.select { |reservation| reservation.room_num == 3 }

      room1_before = room1_reservations.count
      room2_before = room2_reservations.count
      room3_before = room3_reservations.count

      overlap_before
      overlap_after

      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }
      room3_reservations = @booking.reservations.select { |reservation| reservation.room_num == 3 }

      room1_after = room1_reservations.count
      room2_after = room2_reservations.count
      room3_after = room3_reservations.count

      expect(room1_after).must_equal room1_before
      expect(room2_after).must_equal room2_before + 1
      expect(room3_after).must_equal room3_before + 1
    end

    it "selects the same room when requested date does not overlap" do

      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }

      room1_before = room1_reservations.count
      room2_before = room2_reservations.count

      no_overlap_before
      no_overlap_after

      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }

      room1_after = room1_reservations.count
      room2_after = room2_reservations.count

      expect(room1_after).must_equal room1_before + 2
      expect(room2_after).must_equal room2_before
    end

    it "selects the same room when requested date ends on check_in date" do
      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }

      room1_before = room1_reservations.count
      room2_before = room2_reservations.count

      end_on_checkin

      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }

      room1_after = room1_reservations.count
      room2_after = room2_reservations.count

      expect(room1_after).must_equal room1_before + 1
      expect(room2_after).must_equal room2_before
    end

    it "selects the same room when requested date starts on check_out date" do
      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }

      room1_before = room1_reservations.count
      room2_before = room2_reservations.count

      starts_on_checkout

      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }

      room1_after = room1_reservations.count
      room2_after = room2_reservations.count

      expect(room1_after).must_equal room1_before + 1
      expect(room2_after).must_equal room2_before
    end

    it 'assigns a reservation id to the new reservation consecutively' do
      no_overlap_before
      no_overlap_after
      expect(no_overlap_after.id).must_equal no_overlap_before.id + 1
    end

    it 'raises an exception when there are no rooms available for specified date' do
      check_in = "Oct 4 2018"
      check_out = "Oct 7 2018"

      19.times do |i|
        @booking.reserve_room(check_in, check_out)
      end

      expect {
        @booking.reserve_room(check_in, check_out)
      }.must_raise StandardError
    end

    it 'selects another room when requested date overlaps with block' do
      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }
      room3_reservations = @booking.reservations.select { |reservation| reservation.room_num == 3 }
      room4_reservations = @booking.reservations.select { |reservation| reservation.room_num == 4 }
      room5_reservations = @booking.reservations.select { |reservation| reservation.room_num == 5 }
      room6_reservations = @booking.reservations.select { |reservation| reservation.room_num == 6 }

      room1_before = room1_reservations.count
      room2_before = room2_reservations.count
      room3_before = room3_reservations.count
      room4_before = room4_reservations.count
      room5_before = room5_reservations.count
      room6_before = room6_reservations.count

      overlap_block

      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      room2_reservations = @booking.reservations.select { |reservation| reservation.room_num == 2 }
      room3_reservations = @booking.reservations.select { |reservation| reservation.room_num == 3 }
      room4_reservations = @booking.reservations.select { |reservation| reservation.room_num == 4 }
      room5_reservations = @booking.reservations.select { |reservation| reservation.room_num == 5 }
      room6_reservations = @booking.reservations.select { |reservation| reservation.room_num == 6 }

      room1_after = room1_reservations.count
      room2_after = room2_reservations.count
      room3_after = room3_reservations.count
      room4_after = room4_reservations.count
      room5_after = room5_reservations.count
      room6_after = room6_reservations.count

      expect(room1_after).must_equal room1_before
      expect(room2_after).must_equal room2_before
      expect(room3_after).must_equal room3_before
      expect(room4_after).must_equal room4_before
      expect(room5_after).must_equal room5_before
      expect(room6_after).must_equal room6_before + 1
    end
  end

  describe 'date_range' do
    before do
      check_in = "Oct 4 2018"
      check_out = "Oct 7 2018"
      @my_dates = @booking.date_range(check_in, check_out)
    end

    it 'returns an array of dates' do
      expect(@my_dates).must_be_kind_of Array
    end

    it 'returns date range but excluding check_out_date' do
      expect(@my_dates[0]).must_equal Date.parse("Oct 4 2018")
      expect(@my_dates[1]).must_equal Date.parse("Oct 5 2018")
      expect(@my_dates[2]).must_equal Date.parse("Oct 6 2018")
      expect(@my_dates[3]).must_be_nil
    end
  end

  describe 'reservations_by_date' do
    it 'returns a list of reservations for a specified date' do
      overlap_before
      overlap_after
      contained_in_range

      expect(@booking.reservations_by_date("Oct 5 2018")).must_be_kind_of Array
      expect(@booking.reservations_by_date("Oct 5 2018").count).must_equal 4
      expect(@booking.reservations_by_date("Oct 5 2018")[0]).must_be_kind_of Reservation
    end

    it 'returns an empty array if no reservations exist for a specified date' do
      expect(@booking.reservations_by_date("Jan 5 2019")).must_equal []
    end
  end

  describe 'total_cost_of_reservation' do
    it 'returns the cost of a specified reservation' do
      expect(@booking.total_cost_of_reservation(@booking.reservations[0].id)).must_equal (Date.parse("Oct 7 2018") - Date.parse("Oct 4 2018")) * 200
    end

    it 'returns nil if a reservation does not exist' do
      expect(@booking.total_cost_of_reservation(9999)).must_be_nil
    end
  end

  describe 'unreserved_rooms_by_date' do
    before do
      overlap_before
      overlap_after
      contained_in_range
    end

    it 'returns an array of unreserved rooms given a date range that conflicts' do
      start_date = "Oct 4 2018"
      end_date = "Oct 7 2018"
      unreserved_rooms = @booking.unreserved_rooms_by_date(start_date, end_date)

      expect(unreserved_rooms).must_be_kind_of Array
      expect(unreserved_rooms.count).must_equal 16
    end

    it "returns same number of unreserved_rooms given a date range that doesn't conflict" do
      start_date = "Nov 4 2018"
      end_date = "Nov 7 2018"
      unreserved_rooms = @booking.unreserved_rooms_by_date(start_date, end_date)

      expect(unreserved_rooms.count).must_equal 20
    end
  end

  describe 'create_block_of_rooms' do
    it 'returns a BlockOfRooms instance with 5 elements max representing block of rooms' do
      start_date = "Oct 4 2018"
      end_date = "Oct 7 2018"
      discounted_rate = 180
      my_block = @booking.create_block_of_rooms(start_date, end_date, 180)

      expect(my_block).must_be_kind_of RoomBlock
      expect(my_block.check_in_date).must_equal Date.parse(start_date)
      expect(my_block.check_out_date).must_equal Date.parse(end_date)
      expect(my_block.room_cost).must_equal discounted_rate
      expect(my_block.collection_rooms.count).must_equal 5
      expect(my_block.collection_rooms.count).must_be :<=, 5
    end
  end

  describe 'block_available?' do
    it 'returns true if block has availability' do
      expect(@booking.block_available?(@booking.room_blocks[0].id)).must_equal true
    end

    it 'returns false if block has no availability' do
      5.times do |i|
        @booking.reserve_within_block(@booking.room_blocks[0].id)
      end

      expect(@booking.block_available?(@booking.room_blocks[0].id)).must_equal false
    end
  end

  describe 'reserve_within_block' do
    it 'creates a reservation within a block' do
      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      num_reservations_before = room1_reservations.count

      @booking.reserve_within_block(@booking.room_blocks[0].id)

      room1_reservations = @booking.reservations.select { |reservation| reservation.room_num == 1 }
      num_reservations_after = room1_reservations.count

      expect(num_reservations_after).must_equal num_reservations_before + 1
    end

    it 'raises a StandardError if no reservations available within block' do
      5.times do |i|
        @booking.reserve_within_block(@booking.room_blocks[0].id)
      end

      expect {
        @booking.reserve_within_block(@booking.room_blocks[0].id)
      }.must_raise StandardError
    end
  end
end
