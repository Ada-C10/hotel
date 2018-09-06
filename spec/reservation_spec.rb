require_relative 'spec_helper'
require 'pry'

describe "Reservation" do
  let (:room) {
    hotel = HotelAdmin.new
    room_set = hotel.build_rooms
    room_set[0]
  }
  let (:room2) {
    hotel = HotelAdmin.new
    room_set = hotel.build_rooms
    room_set[1]
  }

  let (:reservation) {
    Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: room, date_range: [Date.new(2018,10,20),Date.new(2018,10,22)]})
  }
  let (:reservation2) {
    Reservation.new({guest_id: "Guccifer2.0@ada.com", room: room, date_range: [Date.new(2018,12,02),Date.new(2018,12,07)]})
  }
  let (:reservation3) {
    Reservation.new({guest_id: "Jfahmy07@gmail.com", room: room2, date_range: [Date.new(2018,12,03),Date.new(2018,12,06)]})
  }

  describe "#initialize" do

    it "creates a reservation object" do
      expect(reservation).must_be_instance_of Reservation
    end

    it "returns a guest id as an email" do
      expect(reservation.guest_id).must_equal "SoccerMom2010@gmail.com"
    end

    it "returns a room id" do
      expect(reservation.room).must_be_instance_of Room
    end

    it "returns a date range for guests stay" do
        expect(reservation.date_range).must_equal [Date.new(2018,10,20),Date.new(2018,10,22)]
    end

    it "can calculate guest's stay cost and return it" do
      expect(reservation.cost).must_equal 400.00
    end

  end

end
