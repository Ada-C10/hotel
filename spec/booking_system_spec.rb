require_relative 'spec_helper'
require 'pry'

describe 'BookingSystem class' do
  before do
    @booking = BookingSystem.new
    @booking.reserve_room("Oct 4 2018", "Oct 7 2018")
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


  describe 'Initializer' do
    it 'is an instance of BookingSystem' do
      expect(@booking).must_be_kind_of BookingSystem
    end

    it 'loads an array of rooms' do
      expect(@booking.rooms).must_be_kind_of Array
    end

  end

  describe 'load_rooms' do
    it 'is an instance of Room' do
      expect(@booking.rooms.first).must_be_kind_of Room
    end
  end

  describe 'list_all_rooms' do
    it 'returns a list of all the rooms in the hotel' do
      expect(@booking.list_all_rooms).must_be_kind_of Array
      expect(@booking.list_all_rooms[0]).must_be_kind_of Room
    end
  end

  describe 'reserve_room' do
    it 'adds a new reservation to the list of reservations' do
      before_res = @booking.reservations.count
      overlap_before

      expect(@booking.reservations.count).must_equal before_res + 1
    end

    it "selects the next room when requested date overlaps" do
      room1_before = @booking.rooms[0].reservations.count
      room2_before = @booking.rooms[1].reservations.count
      room3_before = @booking.rooms[2].reservations.count
      overlap_before
      overlap_after
      room1_after = @booking.rooms[0].reservations.count
      room2_after = @booking.rooms[1].reservations.count
      room3_after = @booking.rooms[2].reservations.count

      expect(room1_after).must_equal room1_before
      expect(room2_after).must_equal room2_before + 1
      expect(room3_after).must_equal room3_before + 1
    end

    it "selects the same room when requested date does not overlap" do
      room1_before = @booking.rooms[0].reservations.count
      room2_before = @booking.rooms[1].reservations.count
      no_overlap_before
      no_overlap_after
      room1_after = @booking.rooms[0].reservations.count
      room2_after = @booking.rooms[1].reservations.count

      expect(room1_after).must_equal room1_before + 2
      expect(room2_after).must_equal room2_before
    end

    it "selects the same room when requested date ends on check_in date" do
      room1_before = @booking.rooms[0].reservations.count
      room2_before = @booking.rooms[1].reservations.count
      end_on_checkin
      room1_after = @booking.rooms[0].reservations.count
      room2_after = @booking.rooms[1].reservations.count

      expect(room1_after).must_equal room1_before + 1
      expect(room2_after).must_equal room2_before
    end

    it "selects the same room when requested date starts on check_out date" do
      room1_before = @booking.rooms[0].reservations.count
      room2_before = @booking.rooms[1].reservations.count
      end_on_checkin
      room1_after = @booking.rooms[0].reservations.count
      room2_after = @booking.rooms[1].reservations.count

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
      }.must_raise ArgumentError
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
      expect(unreserved_rooms[0]).must_be_kind_of Room
      expect(unreserved_rooms.count).must_equal 16
    end

    it "returns same number of unreserved_rooms given a date range that doesn't conflict" do

      start_date = "Nov 4 2018"
      end_date = "Nov 7 2018"
      unreserved_rooms = @booking.unreserved_rooms_by_date(start_date, end_date)

      expect(unreserved_rooms.count).must_equal 20
    end
  end
#
#   describe 'create_block_of_rooms' do
#     it 'returns an array with 5 elements max representing block of rooms' do
#       start_date = "Oct 4 2018"
#       end_date = "Oct 7 2018"
#       block_rooms = @booking.create_block_of_rooms(start_date, end_date)
#
#       expect(block_rooms).must_be_kind_of Array
#       expect(block_rooms[0]).must_be_kind_of Room
#       expect(block_rooms.count).must_be :<=, 5
#     end
#   end
end
