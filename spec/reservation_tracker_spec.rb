require_relative 'spec_helper'

describe "TripDispatcher class" do
  before do
    @reservation_tracker = Hotel::ReservationTracker.new
  end

  describe "Initializer" do
    it "is an instance of ReservationTracker" do
      expect(@reservation_tracker).must_be_kind_of Hotel::ReservationTracker
    end

    it "establishes the base data structures when instantiated" do
      [:rooms, :reservations].each do |prop|
        expect(@reservation_tracker).must_respond_to prop
      end
      expect(@reservation_tracker.rooms).must_be_kind_of Array
      expect(@reservation_tracker.reservations).must_be_kind_of Array
    end
  end

  describe "#load_rooms method" do
    it "loads the rooms" do


    end

    it "raises an error if there are less than 1 room" do

    end

    it "raises an error if there are more than 20 rooms" do

    end

  end

  describe "#list_reservations_by_date method" do
    it "lists the reservations searched for by date" do

    end
  end

  describe "#find_unavailable_rooms method" do
    it "finds all unavailable rooms for requested dates" do

    end

    it "returns 0 if there are no unavailable rooms for requested dates" do
    end

  end

  describe "#find_available_rooms method" do
    it "finds all available rooms for requested dates" do

    end

    it "raises an error if there are no rooms available for requested dates" do

    end
  end

  describe "#get_first_available_room method for requested dates" do
    it "returns the first available room for requested dates" do

    end
  end

  describe "#reserve_room method" do
    it "reserves a room if one is available for requested dates" do

    end
  end
end
