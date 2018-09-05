require_relative 'spec_helper'

describe "BookingManager class" do
  describe "Initializer" do
    it "is an instance of BookingManager" do
      manager = Hotel::BookingManager.new
      expect(manager).must_be_kind_of Hotel::BookingManager
    end # of it instance bookingmanager

    it "creates the proper structures for instance variables instantiated" do
      hotel_rooms = Hotel::BookingManager.new

      expect (hotel_rooms.rooms).must_be_kind_of Array
      expect (hotel_rooms.reservations).must_be_kind_of Array
    end
  end # of initializer describe

end # end of describe BookingManager class
