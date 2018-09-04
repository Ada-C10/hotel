require_relative 'spec_helper'

describe "Room class" do

  describe "Room instantiation" do
    before do
      @room = Room.new(1)
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Room
    end

    it "can return a room number" do
      expect(@room.room_number).must_equal 1
    end
  end
end
