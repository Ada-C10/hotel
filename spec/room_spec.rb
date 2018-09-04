require_relative 'spec_helper'

describe "Room Test" do
  describe "initialize" do
    before do
      @new_room = Room.new(1)
    end
    it "is an instance of Room" do
      expect(@new_room).must_be_kind_of Room
    end
  end

  describe "Room.list method" do
      new_room = Room.new(1)
      new_room2 = Room.new(2)
      new_room3 = Room.new(3)
    it "Provides a list of all rooms" do
      expect(Room.list).must_be_kind_of Array
      expect(Room.list[0]).must_be_kind_of Room
      #expect(Room.list.length).must_equal 3
    end
  end
end
