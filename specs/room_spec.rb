require_relative 'spec_helper'
require 'pry'

describe "Room class" do
  before do
    @room = Hotel::Room.new(
      room_num: 1,
    )
  end

  describe "Room instantiation" do
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end


    it "is set up for specific attributes and data types" do
      [:room_num, :rate].each do |prop|
        expect(@room).must_respond_to prop
      end
      expect(@room.room_num).must_be_kind_of Integer
      expect(@room.rate).must_be_kind_of Numeric
    end

    it "checks if the Rate entered is valid" do
      expect(@room.check_rate_validity?(9)).must_equal nil
      expect{ @room.check_rate_validity?('9') }.must_raise Hotel::Room::InvalidRateError

    end
  end
end
