require_relative 'spec_helper'
require 'date'
require 'pry'

describe "BookingSystem class" do

  before do
    @system = Hotel::BookingSystem.new
  end

  describe "load rooms" do
    it "loads rooms in an array" do
      @rooms = @system.load_rooms
      # binding.pry
      expect(@rooms).must_be_kind_of Array
    end

    # it "loads each room as an instance of Reservation" do
    #   @rooms = @system.load_rooms
    #   expect(@rooms[0]).must_be_instance_of Hotel::Reservation
    # end
  end

  describe "make reservation" do
    it "makes a reservation" do
      @system.make_reservation(Date.new(2018,1,1), Date.new(2018,1,5))
      reservation = Hotel::Reservation.new(id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      expect(@system.reservations.length).must_equal 1
    end

  end

  describe "assign room" do
    it "assigns the first available room" do

      # @system.make_reservation(Date.new(2018, 1, 1), Date.new(2018, 1, 5))

      reservation1 = Hotel::Reservation.new(id: 1, room: 1, start_date: Date.new(2018, 1, 7), end_date: Date.new(2018, 1, 8), price_per_night: 200)
      @system.reservations << reservation1

      # @system.make_reservation(Date.new(2018, 1, 6), Date.new(2018, 1, 7))

      reservation2 = Hotel::Reservation.new(id: 2, room: 2, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation2


      reservation3 = Hotel::Reservation.new(id: 3, room: @system.assign_available_room(Date.new(2018, 1, 6), Date.new(2018, 1, 9)), start_date: Date.new(2018, 1, 6), end_date: Date.new(2018, 1, 9), price_per_night: 200)
      @system.reservations << reservation3

      expect(reservation3.room).must_equal 2
    end
  end

  describe "search reservation" do
    it "searches for reservations that fall on a specific date" do

      reservation1 = Hotel::Reservation.new(id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 8), price_per_night: 200)
      @system.reservations << reservation1

      reservation2 = Hotel::Reservation.new(id: 2, room: 2, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation2

      expect(@system.search_reservations(Date.new(2018, 1, 4))).must_be_instance_of Array
    end
  end
end
