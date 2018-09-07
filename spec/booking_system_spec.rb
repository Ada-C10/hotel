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
      expect(@booking.rooms).must_be_kind_of Array
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

    it "adds the reservation to the room's list of reservations" do

      first_reservation
      expect(@booking.rooms[0].reservations.count).must_equal 1

      no_overlap_before
      expect(@booking.rooms[0].reservations.count).must_equal 2
      expect(@booking.rooms[1].reservations.count).must_equal 0

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

    it 'assigns a reservation_id to the new reservation consecutively' do
      first_reservation
      no_overlap_before
      expect(no_overlap_before.reservation_id).must_equal first_reservation.reservation_id + 1
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

      expect(@booking.total_cost_of_reservation(first_reservation.reservation_id)).must_equal (Date.parse("Oct 7 2018") - Date.parse("Oct 4 2018")) * 200
    end
  end
end
