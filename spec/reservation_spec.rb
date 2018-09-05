require_relative 'spec_helper'
require 'pry'

describe "Reservation" do

  let (:reservation) {
    Reservation.new({guest_id: "SoccerMom2010@gmail.com", room_id: 1, date_range: [Date.new(2018,10,20),Date.new(2018,10,22)]})
  }
  let (:reservation2) {
    Reservation.new({guest_id: "Guccifer2.0@ada.com", room_id: 1, date_range: [Date.new(2018,12,02),Date.new(2018,12,07)]})
  }
  let (:reservation3) {
    Reservation.new({guest_id: "Jfahmy07@gmail.com", room_id: 2, date_range: [Date.new(2018,12,03),Date.new(2018,12,06)]})
  }

  describe "#initialize" do

    it "creates a reservation object" do
      expect(reservation).must_be_instance_of Reservation
    end

    it "returns a guest id as an email" do
      expect(reservation.guest_id).must_equal "SoccerMom2010@gmail.com"
    end

    it "returns a room id" do
      expect(reservation.room_id).must_equal 1
    end

    it "returns a date range for guests stay" do
        expect(reservation.date_range).must_equal [Date.new(2018,10,20),Date.new(2018,10,22)]
    end

    it "can calculate guest's stay cost and return it" do
      expect(reservation.cost).must_equal 400.00
    end

    it "adds the room to the reservations class variable" do


    end
  end

  # describe "Reservation#retrieve_by_date" do
  #   it "raises an argument error if invalid date object is provided" do
  #     expect{ (Reservation.retrieve_by_date("I am a string")) }.must_raise ArgumentError
  #   end
  #
  #   it "returns an array of the reservations relevant to given date" do
  #     reservations_for_date = Reservation.retrieve_by_date(Date.new(2018,12,04))
  #     expect(reservations_for_date).must_be_instance_of Array
  #     expect(reservations_for_date.first).must_be_instance_of Reservation
  #     expect(reservations_for_date.length).must_equal 2
  #   end
  # end

  # describe "Reservation#add_reservation" do
  #   it "will add a reservation object to a room's bookings attribute'" do
  #     room.add_reservation(reservation)
  #
  #     expect(room.bookings).wont_be_empty
  #     expect(room.bookings[0]).must_be_instance_of Reservation
  #   end
  # end

end
