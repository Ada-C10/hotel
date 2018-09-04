require_relative 'spec_helper'

describe "Room Test" do
  describe "initialize" do
    before do
      @new_room = Room.new
    end
    it "is an instance of Room" do
      expect(@new_room).must_be_kind_of Room
    end
  end
  describe "Room.list method" do
    it "Provides a list of all rooms" do
      expect(@new_room).must_be_kind_of Array
    end
  end
end
