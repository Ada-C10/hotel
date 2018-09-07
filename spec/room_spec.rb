require_relative 'spec_helper'
require 'pry'

describe "Room Class: Wave One: Tracking Reservations" do
  describe "room class initialize" do
    before do
      @room = Room.new(1)
    end

    it "creates a room" do
      expect(@room).must_be_instance_of Room
    end

  end
end
