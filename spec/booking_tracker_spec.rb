require_relative 'spec_helper'

describe "Booking_Tracker class" do

  before do
    @booking_tracker = BookingTracker.new
  end

  describe "list of all rooms" do
    it "must list all rooms in hotel" do
      rooms = @booking_tracker.rooms

      expect(rooms).must_be_kind_of Array
      expect(rooms.length).must_equal 20
    end

    it "sets base cost of rooms at 200" do
      cost = @booking_tracker.cost

      expect(cost).must_equal 200
    end
  end





end
