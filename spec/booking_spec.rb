require_relative 'spec_helper'
require 'pry'

describe "Booking" do
  describe "initialize" do
    it "Create an instance of hotel" do
      hotel = Booking.new
      hotel.must_be_kind_of Booking
    end

    it "keeps track of rooms" do
      hotel = Booking.new
      hotel.rooms.must_be_kind_of Array
    end

    it "contains 20 rooms in rooms" do
      hotel = Booking.new
      hotel.rooms.length.must_equal 20
    end

    it "keeps track of last room accurately" do
      hotel = Booking.new
      (hotel.rooms[0].room_number).must_equal 1
    end

    it "keeps track of first room accurately" do
      hotel = Booking.new
      (hotel.rooms[19].room_number).must_equal 20
    end
  end
end
