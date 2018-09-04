require_relative 'spec_helper'

describe "Room" do
  describe "#initialize" do
    it "Creates an instance of room" do
      room = Hotel::Room.new(1)
      expect(room).must_be_kind_of Hotel::Room
    end

    it "Keeps track of ID" do
      id = 1337
      room = Hotel::Room.new(id)
      expect(room).must_respond_to :id
      expect(room.id).must_equal id
    end
  end

  # describe "#reserve" do
  #   # This is an instance method that will check to see if room instance is available
  #   room.reserve(date_range)
  # end

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

    it "Gets the first Market from the array" do
      rooms = Hotel::Room.all
      expect(rooms.first.id).must_equal 1
    end

    it "Gets the last Market from the array" do
      rooms = Hotel::Room.all
      expect(rooms.last.id).must_equal 20
    end
  end

  # describe "available_rooms" do
  #   let (:check_in) {
  #     "2018-02-10"
  #   }
  #   let (:check_out) {
  #     "2018-02-16"
  #   }
  #   let (:rooms) {
  #     Hotel::Room.all
  #   }
  #   let (:open_rooms) {
  #     Hotel::Room.available_rooms(check_in, check_out)
  #   }
  #
  #   it "returns an array of Rooms" do
  #     expect(open_rooms).must_be_kind_of Array
  #   end
  #
  #   it "Returns an array full of Rooms" do
  #     open_rooms.each do |room|
  #       expect(room).must_be_kind_of Hotel::Room
  #     end
  #   end
  #
  #   it "Returns the correct number of rooms" do
  #     rooms.first.calendar << Date.parse("2018-02-12")
  #     expect(open_rooms.length).must_equal 19
  #   end
  #
  #   it "returns nil if there are no rooms available" do
  #     rooms.each do |room|
  #       room.calendar << Date.parse("2018-02-12")
  #     end
  #
  #     expect(open_rooms).must_be_nil
  #   end
  # end
end
