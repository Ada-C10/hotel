require_relative 'spec_helper'

describe "Room class" do

  describe "Room instantiation" do
    before do
      @room = Room.new(1)
    end

    it "is an instance of Driver" do
      expect(@room).must_be_kind_of Room
    end

    it "can return a room number" do
      expect(@room.number).must_equal 1
    end
  end
end
