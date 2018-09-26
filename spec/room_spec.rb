# Jacquelyn Cheng - Nodes

# Tests for room.rb

require_relative 'spec_helper.rb'

describe "Room class" do
  let (:room) {
    Hotel::Room.new(1)
  }

  describe "Room#initialize" do
    it "instantiates a Room object" do
      expect(room).must_be_instance_of Hotel::Room
    end

    it "has a room number" do
      expect(room.room_num).must_equal 1
    end

    it "defaults to 200.00 for the room rate" do
      expect(room.rate).must_equal 200.00
    end
  end

  describe "Room#room_factory" do
    it "instantiates 20 Room objects with room numbers 1-20" do
      rooms = Hotel::Room.room_factory
      expect(rooms.first).must_be_instance_of Hotel::Room
      expect(rooms.length).must_equal 20
      expect(rooms.first.room_num).must_equal 1
    end
  end

  describe "Room#rate" do
    it "gets the nightly rate for a room" do
      expect(room.rate).must_equal 200.00
    end
  end

  describe "Room#change_rate" do
    it "can change the nightly rate" do
      room.change_rate(150.00)
      expect(room.rate).must_equal 150.00
    end

    it "raises an error if new rate is < 0 or non numeric" do
      expect{room.change_rate(-10)}.must_raise ArgumentError
      expect{room.change_rate("two hundred")}.must_raise ArgumentError
    end
  end
end
