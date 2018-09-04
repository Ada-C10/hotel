require_relative 'spec_helper'
require 'pry'

describe "Room class" do
  before do
    @room = Hotel::Room.new(
      room_number: 1,
      status: :AVAILABLE
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

    it "throws an argument error with an invalid status" do
      expect{
        Hotel::Room.new(
          room_number: 1,
          status:'available'
        )
      }.must_raise ArgumentError
    end

    it "sets booked_reservations to an empty array if not provided" do
      expect(@room.booked_reservations).must_be_kind_of Array
      expect(@room.booked_reservations.length).must_equal 0
    end

    it "is set up for specific attributes and data types" do
      [:room_number, :status].each do |prop|
        expect(@room).must_respond_to prop
      end

      expect(@room.room_number).must_be_kind_of Integer
      expect(@room.status).must_be_kind_of Symbol
    end
  end
end
