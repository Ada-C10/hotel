require_relative 'spec_helper'

describe "Room class" do

  describe "room instatiation" do

    it "is an instance of room" do
      @room = Hotel::Room.new(1)
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "has a room number" do
      @room = Hotel::Room.new(1)
      expect(@room.room_number).must_equal 1
    end

    it "returns argument error if the ID is not 1-20" do
      expect{Hotel::Room.new(29)}.must_raise ArgumentError
    end

  end

  describe "create all rooms" do
    before do
      @rooms = Hotel::Room.create_rooms
    end
    it "creates an array of 20 rooms " do
      expect(@rooms.length).must_equal 20
    end
    it "the ID of the first room is 1" do
      expect(@rooms.first.room_number).must_equal 1
    end
    it "the ID of the last room is 20" do
      expect(@rooms.last.room_number).must_equal 20
    end
  end

  describe "Rooms.all" do
    it "Returns a list of all rooms in hotel" do
      @rooms = Hotel::Room.all
      expect(@rooms).must_be_kind_of Array
      expect(@rooms.length).must_equal 20
      @rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end
  end
end
