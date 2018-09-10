require_relative 'spec_helper'
require 'pry'
require 'Date'

describe "ReservationManager" do
  before do
    @hotel_ada = Hotel::ReservationManager.new(20)
  end

  describe "Initialize ReservationsManager" do
    it "is an instance of Hotel::ReservationsManager" do
      expect(@hotel_ada).must_be_instance_of Hotel::ReservationManager
      expect(@hotel_ada.reservations).must_be_kind_of Array
    end
  end

  describe "Access all rooms" do
    it "returns a list of all rooms" do
      expect(@hotel_ada.rooms.count).must_equal 20
      expect(@hotel_ada.rooms).must_be_kind_of Array
      expect(@hotel_ada.rooms[0]).must_be_instance_of Hotel::Room
    end

    # wave 2 it "returns a list of all available rooms" do
    #   expect(@hotel_ada.available_rooms(check_in:"08.23.2018", check_out:"08.25.2018")).must_be_kind_of Array
    #   expect(@hotel_ada.available_rooms(check_in:"08.23.2018", check_out:"08.25.2018")[0]).must_be_kind_of Hotel::Room
    #   #expect(@hotel_ada.available_rooms("08.23.2018", "08.25.2018")[0].id).must_equal #rooom ID
    # end
  end


  describe "reserve_room ReservationManager" do
    before do
      @new_reservation = @hotel_ada.reserve_room('2018-08-23', '2018-08-25')
    end
    it "can reserve a room for a given date range" do
      expect(@new_reservation).must_be_instance_of Hotel::Reservation
      expect(@new_reservation.id).must_equal 1
      expect(@new_reservation.check_in).must_be_instance_of Date
    end

    it "adds an instance of a room to the reservation" do
      expect(@new_reservation.rooms).must_be_kind_of Array
      expect(@new_reservation.rooms[0]).must_be_instance_of Hotel::Room
    end

    it "adds the reservation to the instance of room" do
      expect(@new_reservation.rooms[0].id).must_equal 1
      expect(@new_reservation.rooms[0].reservations).must_be_kind_of Array
      expect(@new_reservation.rooms[0].reservations[0]).must_be_instance_of Hotel:: Reservation
      expect(@new_reservation.rooms[0].reservations[0].id).must_equal 1
    end
  end

  describe "it can list all reservations for a given date" do
    it "returns a list of rooms for given date" do
      expect(@hotel_ada.booked_reservations("2018-09-09")).must_be_kind_of Array
      expect(@hotel_ada.booked_reservations("2018-09-09")[0]).must_be_instance_of Hotel::Reservation
    end
  end
end

  # describe "List all rooms "
