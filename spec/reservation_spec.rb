require_relative 'spec_helper'

require 'room'
require 'date'

describe "Reservation" do
  before do
    @reservation = Hotel::Reservation.new(Hotel::Room.new(1),"2019-08-08" , "2019-08-10")
  end
  describe "Reservation instatiation" do
    it "creates an object in reservation class" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end
    it "must have a start day" do
      expect(@reservation.start_day).must_be_kind_of Date
    end
    it "must have an end day" do
      expect(@reservation.end_day).must_be_kind_of Date
    end
    it "must have a room" do
      expect(@reservation.room).must_be_kind_of Hotel::Room
    end
  it "must raise error if end date is before start date" do
    expect{Hotel::Reservation.new(Hotel::Room.new(1),"2019-08-13" , "2019-08-10")}.must_raise StandardError
  end
  end
  describe "calculating nights in a reservation" do
    it "correctly adds up the number of nights" do
      expect(@reservation.nights_in_reservation).must_equal 2
    end
  end
  describe "calculating total cost" do
    it "correctly adds up the total cost for a reservation" do
      expect(@reservation.total_cost).must_equal (2 * 200)
    end
  end
end
