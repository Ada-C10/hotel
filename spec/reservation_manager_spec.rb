require_relative 'spec_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'
require 'date'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/reservation_manager.rb'
require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'

describe "ReservationManagers Class" do

  describe "Initializer" do
    before do
      @reservation_manager = ReservationManager.new
    end

    it "returns an instance of ReservationManager" do
      expect(@reservation_manager).must_be_kind_of ReservationManager
    end

    it "initializes the correct data structure" do
      expect(@reservation_manager.rooms).must_be_kind_of Array
      expect(@reservation_manager.reservations).must_be_kind_of Array
    end

    it "creates 20 rooms on initiation" do
      expect(@reservation_manager.rooms.length).must_equal 20
    end
  end

  describe "ReservationManager#make_reservation" do
    before do
      @reservation_manager = ReservationManager.new
    end

    it "creates a reservation" do
      reservation = @reservation_manager.make_reservation(2018923, 2018926)

      expect(reservation).must_be_kind_of Reservation
      reservation.check_in.must_equal 2018923

      reservation_1 = @reservation_manager.make_reservation(2018910, 2018911)
    
    end
  #
  #   it "adds reservation to list of reservarions made" do
  #
  #     @reservation_manager.make_reservation(2018923, 2018926)
  #     expect(@reservation_manager.reservations.length).must_equal 1
  #   end
  end

  # TODO:
  # That you can make a reservation
  # That if you have a reservation in a date range, the next room is selected.
  # If all rooms are booked, an error is produced.
  # If a reservation ends on the new booking date, the room can be reserved.

  # describe "Hotel#find_reservation(date)" do
  #   it "find a reservation using the date" do
  #     hotel = Hotel.new
  #     hotel.make_reservation(2018923, 2018926)
  #     reservation_2 = hotel.make_reservation(20181023, 20181028)
  #
  #     expect(hotel.find_reservation(2018923)).must_be_kind_of Reservation
  #     expect(hotel.find_reservation(20181023)).must_equal reservation_2
  #   end
  #
  #   it "finds the correct reservation using the date" do
  #     hotel = Hotel.new
  #     hotel.make_reservation(2018923, 2018926)
  #     reservation_2 = hotel.make_reservation(20181023, 20181028)
  #
  #     expect(hotel.find_reservation(2018923)).must_be_kind_of Reservation
  #     expect(hotel.find_reservation(20181023)).must_equal reservation_2
  #   end
  # end

  # describe "Hotel#list_rooms_available(start_date, end_date)" do
  #   before do
  #       @hotel = Hotel.new
  #       @hotel.make_reservation(2018923, 2018926)
  #       reservation_2 = @hotel.make_reservation(20181023, 20181028)
  #   end
  #
  #   it "finds room dates" do
  #     binding.pry
  #     expect(@hotel.list_rooms_available(2018923, 201892))
  #   end
  # end
  # describe "Hotel#find_available_rooms(check_in, check_out)" do
  #   before do
  #     hotel = Hotel.new
  #          reservation_1 = hotel.make_reservation(2018923, 2018926)
  #          reservation_2 = hotel.make_reservation(2018923, 2018928)
  #          reservation_3 = hotel.make_reservation(2018925, 2018101)
  #     binding.pry
  #   end
  #
  #   it "returns all rooms that are availble for given dates" do
  #     # binding.pry
  #     expect(hotel.find_available_rooms(2018923, 2018926))
  #   end
  # #
  # end


end
