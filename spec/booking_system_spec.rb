require_relative 'spec_helper'

describe "BookingSystem class" do

  describe "initialize" do
    before do
      @booking = Hotel::BookingSystem.new(rooms = [], reservations = [], availibility = availibility)
    end

    it "is an instance of Reservation" do
      expect(@booking).must_be_kind_of Hotel::BookingSystem
    end

    it "Takes check_in, check_out, cost, and reservation_id" do
      expect(@booking).must_respond_to :rooms
      expect(@booking).must_respond_to :reservations
      expect(@booking).must_respond_to :availibility
    end

    it "is set up for specific attributes and data types" do
      [:rooms, :reservations, :availibility].each do |initial|
        expect(@booking).must_respond_to initial
      end
      expect(@booking.rooms).must_be_kind_of Array
      expect(@booking.reservations).must_be_kind_of Array
      # expect(@booking_system.availibility).must_be_kind_of String
    end
  end

  describe "rooms" do
    before do
      @booking = Hotel::BookingSystem.new(rooms = [], reservations = [], availibility = availibility)
    end
    it "Returns an array all of the rooms in the hotel" do
      expect(@booking.rooms.length).must_equal 20
    end
  end


end
