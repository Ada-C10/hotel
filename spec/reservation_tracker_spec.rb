require_relative 'spec_helper'

describe "ReservationTracker class" do
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
      expect(@reservation_tracker.rooms).must_be_kind_of Array
      expect(@reservation_tracker.rooms.length).must_equal NUM_OF_ROOMS
      expect(@reservation_tracker.rooms.first).must_equal 1
      expect(@reservation_tracker.rooms.last).must_equal 20
    end

    xit "raises an error if there are less than 1 room" do
      expect{ @reservation_tracker.rooms.include? 21 }.must_raise ArgumentError

    end

    xit "raises an error if there are more than 20 rooms" do

    end

  end

  describe "#list_reservations_by_date method" do
    it "lists the reservations searched for by date" do
      reservations = @reservation_tracker.list_reservations_by_date(Date.today)

      expect(reservations).must_be_kind_of Array
      reservations.each do |reservation|
        expect(reservation.date_range.get_range).must_include Date.today
      end
    end
  end

  before do
    @reservation_tracker = Hotel::ReservationTracker.new
    @start_date = Date.today
    @end_date = @start_date + 5
    @input = {
      start_date: @start_date,
      end_date: @end_date
    }

    @reservation_tracker.reserve_room(@input)
    @requested_dates = Hotel::DateRange.new(@start_date, @end_date)
  end

  describe "#find_unavailable_rooms method" do
    it "finds all unavailable rooms for requested dates" do
      unavailable_rooms = @reservation_tracker.find_unavailable_rooms(@requested_dates)
      expect(unavailable_rooms).must_be_kind_of Array
      # expect(unavailable_rooms).length.must_equal 1
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
