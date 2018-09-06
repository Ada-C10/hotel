 require_relative 'spec_helper'
 require 'pry'

describe "Room" do
  before do
    @room = Room.new(1,[] )
  end
  describe "Initialize" do
    it "Can create an instance of Room" do
      expect(@room).kind_of? Room
    end

    it "Has an room_number" do
      expect(@room).must_respond_to :room_number
      expect(@room.room_number).must_equal 1
    end

    it "Has reservations" do
      expect(@room).must_respond_to :reservations
      expect(@room.reservations).must_equal []
    end

    it "ArgumentError if id is not between 1 and 20" do
      expect{Room.new(9999, [])}.must_raise ArgumentError
    end

    it "Has an array of reservations" do
      expect(@room.reservations).kind_of? Array
    end

    it "Returns true if room is available" do
      expect(@room.is_available?(Date.new(2018, 9, 4))).must_equal TRUE
    end

    it "Returns false if room is not available" do
      @room2 = Room.new(1,[
        Reservation.new(1, Date.new(2018, 9, 01), Date.new(2018, 9, 02))
        ])
      expect(@room2.is_available?(Date.new(2018, 9, 1))).must_equal FALSE
    end
  end
end
