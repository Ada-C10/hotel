require_relative 'spec_helper'
require 'pry'

describe 'BookingSystem class' do
  before do
    @booking = BookingSystem.new
  end

  let (:first_reservation) {
    check_in = "Oct 4 2018"
    check_out = "Oct 7 2018"
    @booking.reserve_room(check_in, check_out)
  }

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

      first_reservation

      expect(@booking.reservations.count).must_equal 1
    end

    it "shovels dates from new reservation to a room's dates_booked array" do

      first_reservation

      expect(@booking.rooms[0].dates_booked.count).must_equal 3

      expect(@booking.rooms[1].dates_booked.count).must_equal 0
    end

    it "selects the next room with available dates" do

      first_reservation
      overlap_before

      expect(@booking.rooms[0].dates_booked.count).must_equal 3
      expect(@booking.rooms[1].dates_booked.count).must_equal 3

      overlap_after

      expect(@booking.rooms[0].dates_booked.count).must_equal 3
      expect(@booking.rooms[1].dates_booked.count).must_equal 3
      expect(@booking.rooms[2].dates_booked.count).must_equal 3

      contained_in_range

      expect(@booking.rooms[0].dates_booked.count).must_equal 3
      expect(@booking.rooms[1].dates_booked.count).must_equal 3
      expect(@booking.rooms[2].dates_booked.count).must_equal 3
      expect(@booking.rooms[3].dates_booked.count).must_equal 1
    end

    it 'selects the same room due to availability' do

      first_reservation
      no_overlap_before

      expect(@booking.rooms[0].dates_booked.count).must_equal 6
      expect(@booking.rooms[1].dates_booked.count).must_equal 0

      no_overlap_after

      expect(@booking.rooms[0].dates_booked.count).must_equal 9
      expect(@booking.rooms[1].dates_booked.count).must_equal 0

      end_on_checkin

      expect(@booking.rooms[0].dates_booked.count).must_equal 12
      expect(@booking.rooms[1].dates_booked.count).must_equal 0

      starts_on_checkout

      expect(@booking.rooms[0].dates_booked.count).must_equal 15
      expect(@booking.rooms[1].dates_booked.count).must_equal 0
    end

    it 'assigns a reservation id to the new reservation consecutively' do
      first_reservation
      no_overlap_before
      expect(no_overlap_before.id).must_equal first_reservation.id + 1
    end

    it 'raises an exception when there are no rooms available for specified date' do
      check_in = "Oct 4 2018"
      check_out = "Oct 7 2018"

      20.times do |i|
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
      first_reservation
      overlap_before
      overlap_after
      contained_in_range

      expect(@booking.reservations_by_date("Oct 5 2018")).must_be_kind_of Array
      expect(@booking.reservations_by_date("Oct 5 2018").count).must_equal 4
      expect(@booking.reservations_by_date("Oct 5 2018")[0]).must_be_kind_of Reservation
    end

    it 'returns an empty array if no reservations exist for a specified date' do
      expect(@booking.reservations_by_date("Oct 5 2018")).must_equal []
    end
  end

  describe 'total_cost_of_reservation' do
    it 'returns the cost of a specified reservation' do
      expect(@booking.total_cost_of_reservation(first_reservation.id)).must_equal (Date.parse("Oct 7 2018") - Date.parse("Oct 4 2018")) * 200
    end

    it 'returns nil if a reservation does not exist' do
      expect(@booking.total_cost_of_reservation(9999)).must_be_nil
    end
  end

  describe 'unreserved_rooms_by_date' do
    before do
      first_reservation
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

  describe 'create_block_of_rooms' do
    it 'returns an array with 5 elements max representing block of rooms' do
      start_date = "Oct 4 2018"
      end_date = "Oct 7 2018"
      block_rooms = @booking.create_block_of_rooms(start_date, end_date)

      expect(block_rooms).must_be_kind_of Array
      expect(block_rooms[0]).must_be_kind_of Room
      expect(block_rooms.count).must_be :<=, 5
    end
  end
end
