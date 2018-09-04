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

    it "Has an id" do
      expect(@room.id).must_equal 1
    end

    it "ArgumentError if id is not between 1 and 20" do
      expect{Room.new(9999, [])}.must_raise ArgumentError
    end

    it "Has an array of reservations" do
      expect(@room.reservations).kind_of? Array
    end

  end

end
