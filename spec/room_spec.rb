require_relative 'spec_helper'
require 'pry'

describe "Room class" do
  before do
    @room = Hotel::Room.new(
      room_number: 1,
    )

    @reservation_1 = Hotel::Reservation.new(
      id: 1,
      room: 1,
      start_date: Date.today,
      end_date: Date.today + 5,
    )
  end

  describe "Room instantiation" do
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "throws an argument error with a bad Room Number" do
      expect{
        Hotel::Room.new(
          room_number: 0,
        )
      }.must_raise ArgumentError

      expect{
        Hotel::Room.new(
          room_number: 21,
        )
      }.must_raise ArgumentError
    end

    it "sets booked_reservations to an empty array if not provided" do
      expect(@room.booked_reservations).must_be_kind_of Array
      expect(@room.booked_reservations.length).must_equal 0
    end

    it "is set up for specific attributes and data types" do
      [:room_number].each do |prop|
        expect(@room).must_respond_to prop
      end

      expect(@room.room_number).must_be_kind_of Integer
    end
  end

  describe "#add_booked_reservation method" do
    it "throws an argument error if trip is not provided" do
      expect{ @room.add_booked_reservation(1) }.must_raise ArgumentError
    end

    it "increases the trip count by one" do
      previous = @room.booked_reservations.length
      @room.add_booked_reservation(@reservation_1)
      expect(@room.booked_reservations.length).must_equal previous + 1
    end
  end
end
