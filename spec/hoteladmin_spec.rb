require_relative 'spec_helper'
require 'pry'

describe "HotelAdmin" do
  let (:hotel) {
     HotelAdmin.new
  }
  describe "HotelAdmin#Initialize" do
    it "can create a hoteladmin object" do
      expect(hotel).must_be_instance_of HotelAdmin
    end

    it "initializes with readable rooms and reservations array attributes" do
      expect(hotel.rooms).must_be_instance_of Array
      expect(hotel.reservations).must_be_instance_of Array
      expect(hotel.rooms).must_be_empty
      expect(hotel.reservations).must_be_empty
    end
  end

  describe "HotelAdmin#list_rooms" do
    it "will return the array room objects" do
          20.times do |index|
            hotel.rooms << Room.new(index+1)
          end
          expect(hotel.list_rooms[0]).must_be_instance_of Room
          expect(hotel.list_rooms).must_be_instance_of Array
          expect(hotel.list_rooms.length).must_equal 20
    end
  end

  describe "HotelAdmin#retrieve_by_date" do
    before do
      hotel.reservations << Reservation.new("SoccerMom2010@gmail.com", 1, [Date.new(2018,10,20),Date.new(2018,10,22)])
      hotel.reservations << Reservation.new("Guccifer2.0@ada.com", 1, [Date.new(2018,12,02),Date.new(2018,12,07)])
      hotel.reservations << Reservation.new("Jfahmy07@gmail.com", 2, [Date.new(2018,12,03),Date.new(2018,12,06)])
    end

    it "raises an argument error if invalid date object is provided" do
      expect{ (hotel.retrieve_by_date("I am a string")) }.must_raise ArgumentError
    end

    it "returns an array of the reservations relevant to given date" do
      reservations_for_date = hotel.retrieve_by_date(Date.new(2018,12,04))

      expect(reservations_for_date).must_be_instance_of Array
      expect(reservations_for_date.first).must_be_instance_of Reservation
      expect(reservations_for_date.length).must_equal 2
    end
  end

  describe "HotelAdmin#reserve_room" do
    before do
      test_reservation = reserve_room("FishandChipsgrl@gmail.com", 4, Date.new(2019,01,20), Date.new(2019,01,22))
    end

    it "returns the new reservation object" do
      expect(test_reservation.guest_id).must_equal "FishandChipsgrl@gmail.com"
      expect(test_reservation.room_id).must_equal 4
      expect(test_reservation.date_range).must_equal [Date.new(2019,01,20), Date.new(2019,01,22)]
    end

    it "adds new reservation to the hoteladmin object's reservations array" do
      expect(hotel.reservations).must_equal 1
    end
  end

end
