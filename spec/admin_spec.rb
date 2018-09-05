require_relative 'spec_helper'
require 'pry'

describe "Booking" do
  describe "initialize" do
    it "Create an instance of hotel" do
      hotel = Admin.new
      hotel.must_be_kind_of Admin
    end

    it "keeps track of rooms" do
      hotel = Admin.new
      hotel.rooms.must_be_kind_of Array
    end

    it "contains 20 rooms in rooms" do
      hotel = Admin.new
      hotel.rooms.length.must_equal 20
    end

    it "keeps track of last room accurately" do
      hotel = Admin.new
      (hotel.rooms[0].room_number).must_equal 1
    end

    it "keeps track of first room accurately" do
      hotel = Admin.new
      (hotel.rooms[19].room_number).must_equal 20
    end

    it "starts with no reservations" do
      hotel = Admin.new
      hotel.reservations.count.must_equal 0
    end

  end

  describe "select room" do
    it "selects the first available room" do
      hotel = Admin.new
      (hotel.select_room).must_be_kind_of Room
      # binding.pry
    end

    describe "add reservations" do
      it "increase count by 1 when add reservation" do
        hotel = Admin.new
        reserve1 = Reservation.new(7, 4, "2018-12-09", "2018-12-15")
        hotel.add_reservation(reserve1)

        hotel.reservations.count.must_equal 1
      end

    end

    describe "request_reservations" do
      it "admin is able to book a reservation" do
        # arrange
        hotel = Admin.new
        reserve1 = Reservation.new(7, 4, "2018-12-09", "2018-12-15")
        # action
        hotel.request_reservation("2018-12-09", "2018-12-15")
        # assert
        hotel.reservations[0].start_date.must_equal Date.parse("2018-12-09")
      end

      it "increases id number by 1 when each reservation is added" do
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")

        new_reservation = hotel.reservations[0]

        new_reservation.id.must_equal 1
      end

      # it "changes room used to unavailable" do
      #   hotel = Admin.new
      #   hotel.request_reservation("2018-12-09", "2018-12-15")
      #   hotel.request_reservation("2018-12-11", "2018-12-17")
      #   second_reservation = hotel.reservations[1]
      #
      #   second_reservation.room.must_equal 2
      # end

    end

    describe "reservations_by_date" do
      it "sorts reservations based on date" do
        #arrange
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-11", "2018-12-17")
        hotel.request_reservation("2018-4-11", "2018-4-12")
        #action
        specific_date = hotel.reservations_by_date("2018-12-12")
        binding.pry
        #assert
        specific_date.length.must_equal 2

      end
    end

    describe "reservation_cost" do
      it "accurately calculates cost of reservation" do
        hotel = Admin.new
        reserve1 = hotel.request_reservation("2018-12-09", "2018-12-15")

        cost = hotel.reservation_cost(reserve1)

        cost.must_equal 1200
      end
    end

  end

end
