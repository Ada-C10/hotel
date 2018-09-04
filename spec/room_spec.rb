require_relative 'spec_helper'
require 'pry'

describe "Room Class: Wave One: Tracking Reservations" do
  describe "room class initialize" do
    before do
      @room = Room.new(1, 200)
    end

    it "creates a room" do
      expect(@room).must_be_instance_of Room
    end

    it "gives the room a cost" do
      expect(@room.cost).must_equal 200
    end

  end
end
