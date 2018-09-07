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

  describe "#reservations_overlaps? method" do
    it "checks if the requested dates overlap with all existing reservations" do
      matching_reservations = @reservation_tracker.reservations_overlaps?(@requested_dates)
      expect(matching_reservations).must_be_kind_of Array
      expect(matching_reservations.length).must_equal 1
      expect(matching_reservations.first).must_be_kind_of Hotel::Reservation

    end
  end

  describe "#find_unavailable_rooms method" do
    it "finds all unavailable rooms for requested dates" do
      unavailable_rooms = @reservation_tracker.find_unavailable_rooms(@requested_dates)
      expect(unavailable_rooms).must_be_kind_of Array
      expect(unavailable_rooms.length).must_equal 1
      expect(unavailable_rooms.first).must_be_kind_of Integer
    end

    it "returns [] if there are no unavailable rooms for requested dates" do
      reservation_tracker = Hotel::ReservationTracker.new
      unavailable_rooms = reservation_tracker.find_unavailable_rooms(@requested_dates)
      expect(unavailable_rooms).must_equal []
    end
  end

  describe "#find_available_rooms method" do
    it "finds all available rooms for requested dates" do
      available_rooms = @reservation_tracker.find_available_rooms(@requested_dates)
      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.length).must_equal 19
      expect(available_rooms.first).must_be_kind_of Integer

    end

    it "raises an error if there are no rooms available for requested dates" do
      reservation_tracker = Hotel::ReservationTracker.new

      20.times do
        reservation_tracker.reserve_room(@input)
      end

      expect{ reservation_tracker.find_available_rooms(@requested_dates) }.must_raise ArgumentError
      expect{ reservation_tracker.reserve_room(@input) }.must_raise ArgumentError
    end
  end

  describe "#get_first_available_room method for requested dates" do
    it "returns the first available room for requested dates" do
      first_available_room = @reservation_tracker.get_first_available_room(@requested_dates)
      expect(first_available_room).must_be_kind_of Integer
      expect(first_available_room).must_equal 2
    end
  end

  describe "#reserve_room method" do
    it "reserves a room if one is available for requested dates" do
      previous_num_res = @reservation_tracker.reservations.length

      new_reservation = @reservation_tracker.reserve_room(@input)
      current_num_res = @reservation_tracker.reservations.length

      expect(new_reservation).must_be_kind_of Hotel::Reservation
      expect(current_num_res).must_equal previous_num_res + 1
    end
  end
end
