require_relative 'spec_helper'
require 'pry'

describe "Room Class" do
  describe "Initialize Room" do
    it "is an instance of Hotel::Room" do

      hotel_room = Hotel::Room.new(1)
      expect(hotel_room).must_be_instance_of Hotel::Room
      expect(hotel_room.reservations).must_be_kind_of Array
    end
  end

  # describe "create_rooms" do
  #   it "creates specified number of hotel rooms" do
  #     hotel_ada = Hotel::Room.create_rooms(20)
  #     expect(hotel_ada).must_be_instance_of Hotel::Room
  #     expect(hotel_ada.rooms.count).must_equal 20
  #     expect(hotel_ada.rooms[0]).must_be_instance_of Hotel::Room
  #     expect(hotel_ada.rooms).must_be_kind_of Array


end
