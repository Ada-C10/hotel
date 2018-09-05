require_relative 'spec_helper'

describe "Room class" do
  describe "Initializer" do
    it "is an instance of Room" do
      number = 2
      @room = Hotel::Room.new(number)
      expect(@room).must_be_kind_of Hotel::Room
    end
  end
end
