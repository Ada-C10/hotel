require_relative 'spec_helper'
require 'pry'
require 'date'

describe "ReservationMaker" do
  before do
    ReservationMaker.reset
  end

  describe "tests for various pieces in each incidence of ReservationMaker" do

    it "is an instance of ReservationMaker" do
      start_date = Date.new(2018,2,3)
      end_date = Date.new(2018,2,5)
      @example = ReservationMaker.new(start_date, end_date)
      expect(@example).must_be_kind_of ReservationMaker
    end

    it "is set up for specific attributes and data types" do
      start_date = Date.new(2018,2,3)
      end_date = Date.new(2018,2,5)
      @example = ReservationMaker.new(start_date, end_date)

      expect(@example.create_reservation).must_be_kind_of Reservation
      expect(ReservationMaker.reservations).must_be_kind_of Array
      expect(@example.start_date).must_be_kind_of Date
      expect(@example.end_date).must_be_kind_of Date
      expect(@example.rooms).must_be_kind_of Array
      expect(@example.rooms[0]).must_be_kind_of Integer

    end
  end

  describe "test for errors in input" do
    it "throws an ArgumentError if the start date is after the end date" do
      expect do
        ReservationMaker.new(Date.new(2018, 2, 3), Date.new(2018, 2, 1))
      end.must_raise ArgumentError
    end
  end

  describe "tests for reservations being added to master reservations list" do
    it "collates all reservations into master @@reservations array" do

      start_date1 = Date.new(2018,2,3)
      end_date1 = Date.new(2018,2,5)
      ReservationMaker.new(start_date1, end_date1).create_reservation
      # binding.pry

      start_date2 = Date.new(2018,3,1)
      end_date2 = Date.new(2018,3,2)
      ReservationMaker.new(start_date2, end_date2).create_reservation
      # binding.pry

      expect(ReservationMaker.reservations.length).must_equal 2

    end
  end

  describe "tests for booked rooms being added to the booked rooms list, given a specific date range" do
    it "collates all reservations that have competing dates with the given one into master @booked_rooms array" do

      start_date1 = Date.new(2018,2,3)
      end_date1 = Date.new(2018,2,5)
      ReservationMaker.new(start_date1, end_date1)
      # binding.pry

      start_date2 = Date.new(2018,3,1)
      end_date2 = Date.new(2018,3,2)
      ReservationMaker.new(start_date2, end_date2)
      # binding.pry

      start_date3 = Date.new(2018,3,1)
      end_date3 = Date.new(2018,3,3)
      example = ReservationMaker.new(start_date3, end_date3)
      # binding.pry

      expect(example.length).must_equal 1
      expect(example[0]).must_be_kind_of Integer

    end
  end
end
