require_relative 'spec_helper'
require 'pry'

describe "Room class" do

  describe "Room Number instantiation" do
    before do
      @room = Hotel::Room.new(room_number: 1)
    end
    it "Create a room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
    it "Room contains a room number" do
      expect(@room).include?(room_number: 1)
    end
    it "raises an error for an invalid room number" do
      expect{Hotel::Room.new(room_number: 21)}.must_raise ArgumentError
    end
    it "raises an error for room number less than 1" do
      expect{Hotel::Room.new(room_number: 0)}.must_raise ArgumentError
    end
  end
end
