# Jacquelyn Cheng - Nodes

# Tests for room.rb

require_relative 'spec_helper.rb'

describe "Room class" do
  before do
    @room_number = 1
    @room = Hotel::Room.new(@room_number)
  end

  describe "Room#initialize" do
    it "instantiates a Room object" do
      expect(@room).must_be_instance_of Hotel::Room
    end

    it "has a room number" do
      expect(@room.room_num).must_equal @room_number
    end

    it "must start out as available for all dates in 2019" do
      expect(@room.availability["2019-01-01"]).must_equal :AVAILABLE
      expect(@room.availability["2019-09-19"]).must_equal :AVAILABLE
      expect(@room.availability["2019-12-31"]).must_equal :AVAILABLE
    end

    # it "updates the room count" do
    #   expect(@room.rooms_in_hotel).must_equal 1
    # end
  end

  describe "Room#reserve" do
    before do
      @room.reserve(Date.parse("2019-01-02"), Date.parse("2019-01-06"))
    end

    it "changes a room's status for specified dates only to unavailable" do
      expect(@room.availability["2019-01-01"]).must_equal :AVAILABLE
      expect(@room.availability["2019-01-02"]).must_equal :UNAVAILABLE
      expect(@room.availability["2019-01-05"]).must_equal :UNAVAILABLE
      expect(@room.availability["2019-01-06"]).must_equal :UNAVAILABLE
      # room is available on the night of a reservation's end date
      expect(@room.availability["2019-01-07"]).must_equal :AVAILABLE
    end
  end

end
