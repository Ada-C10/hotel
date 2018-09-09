require_relative 'spec_helper'
require 'pry'

describe "Room class" do

  describe "room instatiation" do

    it "is an instance of room" do
      @room = Room.new(1)
      expect(@room).must_be_kind_of Room
    end

    it "has a room number" do
      @room = Room.new(1)
      expect(@room.room_number).must_equal 1
    end

    it "returns argument error if the ID is not 1-20" do
      expect{Room.new(29)}.must_raise ArgumentError
    end

  end

describe "is a room available" do
  before do
    @room = Room.new(1)
    @room.add_reservation_to_room(Reservation.new(1,"2019-08-05" , "2019-08-10",200))
  end
  it "correctly determines if a room is available on a given date" do
    expect(@room.is_available?(Date.new(2019, 8, 5))).must_equal false
    expect(@room.is_available?(Date.new(2019, 8, 4))).must_equal true
  end
  it "correctly determines that a room is available on the end day of a res" do
    expect(@room.is_available?(Date.new(2019, 8, 10))).must_equal true
  end
end


  end
