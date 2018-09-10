require_relative 'spec_helper'
require 'pry'

describe "Hotel_rooms class" do

  describe "room instantiation" do
    before do
      @hotel_rooms = Hotel::HotelRooms.new
  end

  it "it creates a hotel room" do
    expect(@hotel_rooms).must_be_kind_of Hotel::HotelRooms
  end
end

  describe "list_rooms method" do
    before do
      @hotel_rooms = Hotel::HotelRooms.new
    end

    it "list_rooms method returns an array" do
      expect(@hotel_rooms.list_rooms).must_be_kind_of Array
    end

    it "list_rooms should return an array of 20" do
      expect(@hotel_rooms.list_rooms.length).must_equal 20
    end
  end

  describe "set_up_rooms method" do
    before do
      @hotel_rooms = Hotel::HotelRooms.new
    end

    it "set up method returns an array" do
      expect(@hotel_rooms.set_up_rooms).must_be_kind_of Array
    end

    it "rooms should return an array of 20" do
      expect(@hotel_rooms.rooms.length).must_equal 20
    end
  end

  describe "set_up_reservations method" do
    before do
      @hotel_rooms = Hotel::HotelRooms.new
    end

    it "set_up_reservations returns an hash" do
      expect(@hotel_rooms.set_up_reservations).must_be_kind_of Hash
    end

    it "reservations contains a room number" do
      expect(@reservations).include?(room_number: 1)
    end
  end
end
