require_relative 'spec_helper'

describe "Room Class" do
  describe "Room initiation" do
    before do
      @room = Hotel::Room.new(1)
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

  end
end
