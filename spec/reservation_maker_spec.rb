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
      expect(ReservationMaker.reservations.length).must_equal 1
      expect(@example.start_date).must_be_kind_of Date
      expect(@example.end_date).must_be_kind_of Date
      expect(@example.rooms).must_be_kind_of Array
      expect(@example.rooms[0]).must_be_kind_of Integer
      expect(@example.booked_rooms).must_be_kind_of Array
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

  describe "tests for StandardError if no rooms are available. " do
    it "it will throw an error if all rooms are already booked" do

      available_rooms = nil

      start_date1 = Date.new(2018,2,3)
      end_date1 = Date.new(2018,2,5)
      example1 = ReservationMaker.new(start_date1, end_date1).create_reservation

      expect(ReservationMaker.reservations.length).must_raise StandardError

    end
  end

  describe "tests for StandardError if all rooms are booked. " do
    it "it will throw an error if there are 20 reservations already booked for that date range" do

      available_rooms = nil

      start_date = Date.new(2018,2,3)
      end_date = Date.new(2018,2,5)
      example = nil
      20.times do |i|
        ReservationMaker.new(start_date, end_date).create_reservation
      end

      expect(ReservationMaker.reservations.length).must_equal 20

    end
  end

  describe "tests whether another reservation will be made if all rooms are booked. " do
    it "it will not create another reservation because there are no rooms available for that dates range" do

      available_rooms = nil

      start_date = Date.new(2018,2,3)
      end_date = Date.new(2018,2,5)
      example = nil
      20.times do |i|
        ReservationMaker.new(start_date, end_date).create_reservation
      end

      example = ReservationMaker.new(start_date, end_date).create_reservation

      expect(example.create_reservation).must_raise StandardError

    end
  end

end
