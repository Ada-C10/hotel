require_relative 'spec_helper'

describe "BookingSystem class" do

  describe "initialize" do
    before do
      @booking = Hotel::BookingSystem.new()
    end

    it "is an instance of Reservation" do
      expect(@booking).must_be_kind_of Hotel::BookingSystem
    end

    it "Takes check_in, check_out, cost, and reservation_id" do
      expect(@booking).must_respond_to :rooms
      expect(@booking).must_respond_to :reservations
      # expect(@booking).must_respond_to :availibility
    end

    it "is set up for specific attributes and data types" do
      [:rooms, :reservations].each do |initial|
        expect(@booking).must_respond_to initial
      end
      expect(@booking.rooms).must_be_kind_of Array
      expect(@booking.reservations).must_be_kind_of Array
      # expect(@booking_system.availibility).must_be_kind_of String
    end
  end

  describe "rooms" do
    before do
      @booking = Hotel::BookingSystem.new()
    end
    it "returns an array all of the rooms in the hotel" do
      expect(@booking.rooms.length).must_equal 20
      # puts @booking.rooms
    end

    it "returns a list of available rooms for a given date range"do

    expect(@booking.rooms.length).must_equal 20
    end

  end

  describe "reservations" do
    before do
      @booking = Hotel::BookingSystem.new()
    end
    it "takes check-in and check-out, matches to an availible room, ID and pushes it into reservations array" do

      @booking.make_reservation(200, "2018-02-03", "2018-02-06")
      # puts @booking.reservations.first.reservation_id
      puts @booking.reservations.first.total_cost
      puts @booking.reservations
      expect(@booking.reservations.length).must_equal 1

    end

    it "lists reservations for a specific date" do
      res1 = @booking.make_reservation(200, "2018-02-03", "2018-02-06")
      res2 = @booking.make_reservation(200, "2018-04-03", "2018-04-06")
      puts res1.total_cost
      check_day = @booking.reservations_by_date("2018-02-05")
      expect(check_day.length).must_equal 1
      # binding.pry
      expect(check_day.first).must_equal res1
    end
    it "lists reservations for a specific date range" do
      res1 = @booking.make_reservation(200, "2018-02-03", "2018-02-06")
      res2 = @booking.make_reservation(200, "2018-02-06", "2018-04-10")
      # puts res1.total_cost
      check_day = @booking.reservations_by_date_range(Hotel::DateRange.new("2018-02-05","2018-02-10"))
      expect(check_day.length).must_equal 2
      # binding.pry
      expect(check_day.first).must_equal res1
    end

    it "lists rooms that are available for a date range" do
      res1 = @booking.make_reservation(200, "2018-04-03", "2018-04-06")

      expect(@booking.list_available_rooms(Hotel::DateRange.new("2018-04-03", "2018-04-06")).length).must_equal 19
    end
  end
end
