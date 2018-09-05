require_relative 'spec_helper'

describe "BookingManager class" do
  describe "Initializer" do
    it "creates an instance of BookingManager" do
      manager = Hotel::BookingManager.new(10)
      expect(manager).must_be_kind_of Hotel::BookingManager
    end # of it instance bookingmanager

    it "creates the proper structures for instance variables instantiated" do
      hotel_rooms = Hotel::BookingManager.new(20)

      expect(hotel_rooms.rooms).must_be_kind_of Array
      expect(hotel_rooms.reservations).must_be_kind_of Array
      # expect hotel_rooms.rooms.length must_equal 20
    end
  end # of initializer describe

  describe "Populate Room List method" do
    it "creates an array of Room instances" do
      hotel_rooms = Hotel::BookingManager.new(10)
      first_room = hotel_rooms.rooms.first
      last_room = hotel_rooms.rooms.last

      expect(first_room).must_be_instance_of Hotel::Room
      expect(last_room).must_be_instance_of Hotel::Room
    end # of array Room instance it

    it "assigns numbers to rooms consecutively as instantiated" do
      x = 15
      hotel_rooms = Hotel::BookingManager.new(x)
      first_room = hotel_rooms.rooms.first
      last_room = hotel_rooms.rooms.last

      expect(first_room.number).must_equal 1
      expect(last_room.number).must_equal x
    end

    it "returns array of rooms with length equal to parameter passed into constructor" do
      x = 12
      hotel_rooms = Hotel::BookingManager.new(x)
      expect(hotel_rooms.rooms.length).must_equal x
    end
  end # of reservation and room load methods

end # end of describe BookingManager class
