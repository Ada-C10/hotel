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
end
