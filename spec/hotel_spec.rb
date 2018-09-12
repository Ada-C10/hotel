require_relative 'spec_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'
require 'date'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/hotel.rb'
require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'

describe "Hotel Class" do ####### big describe opening

  describe "Initializer" do
    before do
      @hotel = Hotel.new
    end
    # let (:hotel) { hotel = Hotel.new
    # } => this works but creates warnings => warning: assigned but unused variable - hotel
    it "returns an instance of Hotel" do
      expect(@hotel).must_be_kind_of Hotel
    end

    it "initializes the correct data structure" do
      expect(@hotel.rooms).must_be_kind_of Array
      expect(@hotel.reservations).must_be_kind_of Array
    end

    it "creates 20 rooms on initiation" do
      expect(@hotel.rooms.length).must_equal 20
    end
  end

  describe "Hotel#make_reservation" do
    before do
      @hotel = Hotel.new
      reservation = @hotel.make_reservation(2018923, 2018926)
    end

    it "creates a reservation object" do
      expect(reservation).must_be_kind_of Reservation
    end

    it "adds reservation to list of reservarions made" do
      # expect(@hotel.reservations).must_be_nil
      @hotel.make_reservation(2018923, 2018926)
      expect(@hotel.reservations.length).must_equal 1
    end

    # TODO:
    # it "reserves a room on reservation" do
    #
    # end
  end

  describe "Hotel#find_reservation(date)" do
    it "find a reservation using the date" do
      hotel = Hotel.new
      hotel.make_reservation(2018923, 2018926)
      reservation_2 = hotel.make_reservation(20181023, 20181028)

      expect(hotel.find_reservation(2018923)).must_be_kind_of Reservation
      expect(hotel.find_reservation(20181023)).must_equal reservation_2
    end

    it "finds the correct reservation using the date" do
      hotel = Hotel.new
      hotel.make_reservation(2018923, 2018926)
      reservation_2 = hotel.make_reservation(20181023, 20181028)

      expect(hotel.find_reservation(2018923)).must_be_kind_of Reservation
      expect(hotel.find_reservation(20181023)).must_equal reservation_2
    end
  end

  describe "Hotel#list_rooms_available(start_date, end_date)" do
    before do
        @hotel = Hotel.new
        @hotel.make_reservation(2018923, 2018926)
        reservation_2 = @hotel.make_reservation(20181023, 20181028)
    end

    it "finds room dates" do
      binding.pry
      expect(@hotel.list_rooms_available(2018923, 201892))
    end
  end
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


end #######big describe closing
