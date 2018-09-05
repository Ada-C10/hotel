require_relative 'spec_helper'
require 'pry'

describe "BookingTracker class" do
  before do
    @bookings = BookingTracker.new
    # before do
    @bookings.new_reservation('9-10-2018', '10-10-2018')
    @bookings.new_reservation('9-5-2018', '9-16-2018')
    @bookings.new_reservation('9-15-2018', '9-18-2018')
    # end
  end

  describe "initialization" do

    it "it can access the list of all of the rooms in the hotel" do
      rooms = @bookings.rooms

      expect(rooms).must_be_kind_of Array
      expect(rooms.length).must_equal 20
    end

    it "sets base cost of rooms at 200" do
      cost = @bookings.cost

      expect(cost).must_equal 200
    end
  end

  describe "it can reserve a room for a given date range" do
    before do
      @reservation = @bookings.new_reservation('9-15-2018', '9-17-2018')
    end

    it "must raise ArgumentError for invalid dates" do

      expect { @bookings.new_reservation('10-10-2018', '9-15-2018') }.must_raise ArgumentError
    end

    it "must create a new reservation instance" do

    expect(@reservation).must_be_kind_of Reservation
    end

    it "can find an available_room for the reservation" do

      expect (@reservation.room_num).must_equal 5
    end
  end

  describe "track list of reservations" do

    it "can return a list of all reservations" do
      reservation_list = @bookings.all_reservations

      expect(reservation_list.length).must_equal 3
      expect(reservation_list.first.begin_date.mon).must_equal 9
      expect(reservation_list.first.begin_date.day).must_equal 10
    end

    it "can access the list of reservations for a specific date" do
      reservation_list_by_date = @bookings.reservation_list_by_date('9-17-2018')

      expect (reservation_list_by_date).must_be_kind_of Array
      expect (reservation_list_by_date.length).must_equal 2

    end

    it "can get the total cost for a given reservation" do
      reservation = @bookings.new_reservation('9-1-18', '9-5-18')

      expect (reservation.cost).must_equal 800

    end

  end
end
