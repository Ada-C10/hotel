require_relative 'spec_helper'
require 'pry'

describe "Booking" do
  describe "initialize" do
    it "Creates an instance of hotel" do
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
      (hotel.rooms[0]).must_equal 1
    end

    it "keeps track of first room accurately" do
      hotel = Admin.new
      (hotel.rooms[19]).must_equal 20
    end

    it "starts with no reservations" do
      hotel = Admin.new
      hotel.reservations.count.must_equal 0
    end

  end

  describe "select room" do
    # it "selects the first available room" do
    #   hotel = Admin.new
    #   (hotel.select_room).must_be_kind_of Room
    #   # binding.pry
    # end

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
      #what about a nominal case for rooms?
      it "raises an ArgumentError when no rooms are available" do
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        expect{hotel.request_reservation("2018-12-09", "2018-12-15")}.must_raise ArgumentError
      end

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

    describe "find_reservations_by_date_range" do
      it "accurately finds all reservations during that date range" do
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-11", "2018-12-17")
        hotel.request_reservation("2018-4-11", "2018-4-12")
        #action
        specific_dates = hotel.reservations_by_date_range("2018-12-12", "2018-12-14")
        # binding.pry
        specific_dates.length.must_equal 2
      end

      it "will not include reservation if requested trip start is same date as end_time of other reservation" do
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-11", "2018-12-17")
        hotel.request_reservation("2018-4-11", "2018-4-12")
        #action
        specific_dates = hotel.reservations_by_date_range("2018-12-17", "2018-12-20")

        specific_dates.length.must_equal 0
      end

      it "will include zero reservations is no reservations are during that time range" do
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-11", "2018-12-17")
        hotel.request_reservation("2018-4-11", "2018-4-12")
        #action
        specific_dates = hotel.reservations_by_date_range("2018-3-20", "2018-3-27")

        specific_dates.length.must_equal 0
      end
    end

    describe "available rooms" do
      it "creates an array of available rooms for specific date range" do
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-11", "2018-12-17")
        hotel.request_reservation("2018-4-11", "2018-4-12")

        rooms_available = hotel.available_rooms("2018-12-12", "2018-12-14")
        # binding.pry
        rooms_available.must_be_kind_of Array
        rooms_available.length.must_equal 18
      end

      it "returns available rooms including block reservations" do
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-11", "2018-12-17")
        hotel.request_reservation("2018-4-11", "2018-4-12")
        # binding.pry
        hotel.request_block_reservation(4, "2018-12-12", "2018-12-14")

        rooms_available = hotel.available_rooms("2018-12-12", "2018-12-14")
         # binding.pry
        rooms_available.length.must_equal 14
      end
    end

    describe "request block reservation" do
      it "allows admin to book a block reservation" do
        # arrange
        hotel = Admin.new
        # action
        hotel.request_block_reservation(3, "2018-12-09", "2018-12-15")
        # assert
        hotel.reservations[0].start_date.must_equal Date.parse("2018-12-09")
      end

      it "increases id number by 1 when each reservation is added" do
        hotel = Admin.new
        hotel.request_block_reservation(3, "2018-12-09", "2018-12-15")

        new_reservation = hotel.reservations[0]

        new_reservation.id.must_equal 1
      end

      it "increases raises StandardError when more than 5 rooms are requested" do
        hotel = Admin.new
        expect{hotel.request_block_reservation(6, "2018-12-09", "2018-12-15")}.must_raise StandardError

      end

      it "raises an ArgumentError when no rooms are available" do
        hotel = Admin.new
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")
        hotel.request_reservation("2018-12-09", "2018-12-15")

        expect{hotel.request_block_reservation(5, "2018-12-09", "2018-12-15")}.must_raise StandardError
      end
    end
  end

end
