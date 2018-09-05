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
      expect(hotel.rooms.length).must_equal 20
      expect(hotel.rooms.first).must_be_instance_of Room
      expect(hotel.reservations).must_be_instance_of Array
      expect(hotel.reservations).must_be_empty
    end
  end

  describe "HotelAdmin#build_rooms" do
    it "creates our room objects numbered 1-20" do
      expect(hotel.build_rooms.length).must_equal 20
      expect(hotel.build_rooms.first).must_be_instance_of Room
      expect(hotel.build_rooms).must_be_instance_of Array
    end
  end

  describe "HotelAdmin#list_rooms" do
    it "will return the array room objects" do
          # 20.times do |index|
          #   hotel.rooms << Room.new(index+1)
          # end
          expect(hotel.list_rooms[0]).must_be_instance_of Room
          expect(hotel.list_rooms).must_be_instance_of Array
          expect(hotel.list_rooms.length).must_equal 20
    end
  end

  describe "HotelAdmin#retrieve_by_date" do
    before do
      hotel.reservations << Reservation.new({guest_id: "SoccerMom2010@gmail.com", room_id: 1, date_range: [Date.new(2018,10,20),Date.new(2018,10,22)]})
      hotel.reservations << Reservation.new({guest_id: "Guccifer2.0@ada.com", room_id: 1, date_range: [Date.new(2018,12,02),Date.new(2018,12,07)]})
      hotel.reservations << Reservation.new({guest_id: "Jfahmy07@gmail.com", room_id: 2, date_range: [Date.new(2018,12,03),Date.new(2018,12,06)]})
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
      @reservation = hotel.reserve_room("FishandChipsgrl@gmail.com", 4, Date.new(2019,01,20), Date.new(2019,01,22))
    end

    it "returns the new reservation object" do
      expect(@reservation.guest_id).must_equal "FishandChipsgrl@gmail.com"
      expect(@reservation.room_id).must_equal 4
      expect(@reservation.date_range).must_equal [Date.new(2019,01,20), Date.new(2019,01,22)]
      expect(@reservation.cost).must_equal 400.00
    end

    it "adds new reservation to the hoteladmin object's reservations array" do
      expect(hotel.reservations.first).must_be_instance_of Reservation
      expect(hotel.reservations.length).must_equal 1
    end
  end

  describe "HotelAdmin#reservation_charge" do
    let (:reservation){
      Reservation.new({guest_id: "Guccifer2.0@ada.com", room_id: 1, date_range: [Date.new(2018,12,02),Date.new(2018,12,07)]})
    }
    it "returns the cost associated with a given reservation" do
      expect(reservation.cost).must_equal 1000.00
    end

  end

  describe "HotelAdmin#retrieve_room" do
    let (:room) {
      hotel.retrieve_room(8)
    }

    it "locates room object using a given room number" do
      expect(room).must_be_instance_of Room
      expect(room.room_id).must_equal 8
    end
  end

end
