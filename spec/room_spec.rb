require_relative 'spec_helper'

describe "Room Class" do
  describe "initializer" do
    before do
      @room = Hotel::Room.new()
      end

      it "is an instance of Room" do
        expect(@room).must_be_kind_of Hotel::Room
      end
    end
  end
