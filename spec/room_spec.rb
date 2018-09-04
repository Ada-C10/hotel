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

    # it "updates the room count" do
    #   expect(@room.rooms_in_hotel).must_equal 1
    # end
  end

end
