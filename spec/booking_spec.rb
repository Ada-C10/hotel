require_relative 'spec_helper'

describe "booking manager" do
  before do
    # Make a manager - and test what it has
    # Should have access to 20 rooms in an array
    @manager = Booking.new
  end

  describe "Initialize" do
    it "can create an instance of booking manager" do
      booking_manager = Booking.new
    end

    it "has a rooms array" do
      expect(@manager.rooms).kind_of? Array
    end

    it "has 20 rooms" do
      expect(@manager.rooms.length).must_equal 20
    end
  end

  # Test methods here
  describe "Lists" do
    # Access list of rooms
    it "Shows a list of all the rooms" do
      expect(@manager.list_all.length).must_equal 20
    end
    # Access list of reserved rooms by date
    
    # Access list of rooms not reserved for date range
    # List of block rooms

  end
end
