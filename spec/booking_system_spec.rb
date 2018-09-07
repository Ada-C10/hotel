require_relative 'spec_helper'
require 'date'
require 'pry'

describe "BookingSystem class" do

  before do
    @system = Hotel::BookingSystem.new
  end

  describe "load rooms" do
    it "loads rooms in an array" do
      @rooms = @system.load_rooms
      # binding.pry
      expect(@rooms).must_be_kind_of Array
    end

    # it "loads each room as an instance of Reservation" do
    #   @rooms = @system.load_rooms
    #   expect(@rooms[0]).must_be_instance_of Hotel::Reservation
    # end
  end

  describe "make reservation" do
    it "makes a reservation" do
      @system.make_reservation(Date.new(2018,1,1), Date.new(2018,1,5))
      reservation = Hotel::Reservation.new(id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      expect(@system.reservations.length).must_equal 1
    end

  end

  describe "assign room" do
    it "assigns the first available room" do

      # @system.make_reservation(Date.new(2018, 1, 1), Date.new(2018, 1, 5))

      reservation1 = Hotel::Reservation.new(id: 1, room: 1, start_date: Date.new(2018, 1, 7), end_date: Date.new(2018, 1, 8), price_per_night: 200)
      @system.reservations << reservation1

      # @system.make_reservation(Date.new(2018, 1, 6), Date.new(2018, 1, 7))

      reservation2 = Hotel::Reservation.new(id: 2, room: 2, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation2


      reservation3 = Hotel::Reservation.new(id: 3, room: @system.assign_available_room(Date.new(2018, 1, 6), Date.new(2018, 1, 9)), start_date: Date.new(2018, 1, 6), end_date: Date.new(2018, 1, 9), price_per_night: 200)
      @system.reservations << reservation3
      expect(reservation3.room).must_equal 2
    end
  end

  describe "search reservation dates" do
    before do

      reservation1 = Hotel::Reservation.new(id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 8), price_per_night: 200)
      @system.reservations << reservation1

      reservation2 = Hotel::Reservation.new(id: 2, room: 2, start_date: Date.new(2018, 1, 7), end_date: Date.new(2018, 1, 15), price_per_night: 200)
      @system.reservations << reservation2

    end
    it "returns an array of reservations" do

      expect(@system.search_reservations(Date.new(2018, 1, 4), Date.new(2018, 1, 8))).must_be_instance_of Array
    end

    it "returns reservations that overlap on the existing reservation start date" do

      expect(@system.search_reservations(Date.new(2017, 12, 30), Date.new(2018, 1, 5))[0].id).must_equal 1

    end

    it "returns reservations that overlap on the existing reservation end" do

      expect(@system.search_reservations(Date.new(2018, 1, 10), Date.new(2018, 1, 20))[0].id).must_equal 2

    end

    it "returns multiple reservations that are on the same date" do

      expect(@system.search_reservations(Date.new(2018, 1, 7), Date.new(2018, 1, 15)).length).must_equal 2

    end

    it "does not return reservations that end on the new reservation's start date" do

      expect(@system.search_reservations(Date.new(2018, 1, 15), Date.new(2018, 1, 20)).length).must_equal 0

    end

    it "does not return reservations that start on the new reservation's end date" do

      expect(@system.search_reservations(Date.new(2017, 12, 20), Date.new(2018, 1, 1)).length).must_equal 0

    end

  end

  describe "find reservation method with id" do
    it "returns the corresponding reservation given id" do
      reservation = Hotel::Reservation.new(id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation

      expect(@system.find_reservation(1))[0].id.must_equal 1
    end
  end

  describe "total cost of reservation" do
    it "finds the total cost of reservation given id" do

      reservation = Hotel::Reservation.new(id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation

      expect(@system.total_cost(1)).must_equal 800
    end
  end

end

# Hi! In Edges we talked about interesting test cases for date overlaps this afternoon. Here is a full list of all the cases I’ll be looking for when I give feedback:
#
# Two date ranges *do* overlap if range A compared to range B:
# - Same dates
# - Overlaps in the front
# - Overlaps in the back
# - Completely contained
# - Completely containing
#
# Two date ranges are *not* overlapping if range A compared to range B:
# - Completely before
# - Completely after
# - Ends on the checkin date
# - Starts on the checkout date (edited)
#
#
# start1 = 9
# end1 = 12
# start2 = 8
# end2 = 15
#
# (StartDate1 < EndDate2) and (StartDate2 <= EndDate1)
#
# true true


# def search_reservations(start_date_2, end_date_2)
#   reservations_within_date = []
#   empty_rooms_within_date = []
#   @reservations.each do |reservation|
#     if
#       reservation.start_date < end_date_2 && start_date_2 < reservation.end_date
#       reservations_within_date << reservation
#     else
#       empty_rooms_within_date << reservation.room
#     end
#     # binding.pry
#   end
# end
