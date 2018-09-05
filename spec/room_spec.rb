require_relative 'spec_helper'

describe "Room" do
  describe "#initialize" do
    it "Creates an instance of room" do
      room = Hotel::Room.new(1337)

      expect(room).must_be_kind_of Hotel::Room
    end

    it "Keeps track of ID" do
      id = 1337
      room = Hotel::Room.new(id)

      expect(room).must_respond_to :id
      expect(room.id).must_equal id
    end

    it "Keeps track of Availability Status by Date in a hash" do
      room = Hotel::Room.new(1337)

      expect(room).must_respond_to :status_by_date
      expect(room.status_by_date).must_be_kind_of Hash
      room.status_by_date.each do |date, status|
        expect(date).must_be_kind_of Date
        expect(status).must_be_kind_of Symbol
      end
    end
  end

  describe "all" do
    it "Returns an array full of Rooms" do
      rooms = Hotel::Room.all

      rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end

    it "Returns the correct number of rooms" do
      rooms = Hotel::Room.all
      expect(rooms.length).must_equal 20
    end

    it "Gets the first Room from the array" do
      rooms = Hotel::Room.all
      expect(rooms.first.id).must_equal 1
    end

    it "Gets the last Room from the array" do
      rooms = Hotel::Room.all
      expect(rooms.last.id).must_equal 20
    end
  end
end
