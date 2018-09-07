require_relative 'spec_helper'
require 'pry'

describe "Room" do
  let (:room) {
    Room.new(1)
  }
  let (:room2) {
    Room.new(2)
  }
  let (:reservation) {
    Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: 1, date_range: (Date.new(2018,10,18)..Date.new(2018,10,22))})
  }
  let (:reservation2) {
    Reservation.new({guest_id: "Guccifer2.0@ada.com", room: 2 , date_range: (Date.new(2018,12,02)..Date.new(2018,12,07))})
  }

  describe "Room#initialize" do
    it "can create a room object" do
      expect(room).must_be_instance_of Room
      expect(room.id).must_be_instance_of Integer
    end

    it "initializes a room with an empty array attribute for reservations" do
      expect(room.bookings).must_be_instance_of Array
      expect(room.bookings).must_be_empty
    end
  end

  describe "Room#add_booking" do
    it "will add a reservation object to a room's bookings attribute'" do
      room.add_booking(reservation)

      expect(room.bookings).wont_be_empty
      expect(room.bookings[0]).must_be_instance_of Reservation
    end

    it "will raise an exception if a conflicting reservation is added to a room" do
      bad_reservation = Reservation.new({guest_id: "TellieTubbie@gmail.com", room: 2, date_range: (Date.new(2018,12,02)..Date.new(2018,12,04))})
      room2.add_booking(bad_reservation)

      expect{ room2.add_booking(bad_reservation)
      }.must_raise ArgumentError

    end
  end

  describe "Room#available?" do
    let (:room5) {
      Room.new(5)
    }
    let (:reservation3) {
      Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: 5, date_range: (Date.new(2018,10,18)...Date.new(2018,10,22))})
    }

    it "returns true/false if room is available for given date range" do

      room5.add_booking(reservation3)
      #Test cases provided by Dan on Slack
      #Two date ranges *do* overlap if range A compared to range B:
      #Same dates
      #binding.pry
      expect(room5.available?((Date.new(2018,10,18)...Date.new(2018,10,22)))).must_equal FALSE
      # #overlaps in the front
      expect(room5.available?((Date.new(2018,10,15)...Date.new(2018,10,19)))).must_equal FALSE
      # #overlaps in the back
      expect(room5.available?((Date.new(2018,10,21)...Date.new(2018,10,22)))).must_equal FALSE
      #Completely contained
      expect(room5.available?((Date.new(2018,10,19)...Date.new(2018,10,20)))).must_equal FALSE
      #binding.pry
      #Completely containing
      # expect(room.available?((Date.new(2018,10,17)..Date.new(2018,10,23)))).must_equal FALSE
      #
      # # Two date ranges are *not* overlapping if range A compared to range B:
      # # - Completely before
      expect(room5.available?((Date.new(2018,07,05)...Date.new(2018,07,07)))).must_equal TRUE
      # # - Completely after
      expect(room5.available?((Date.new(2018,11,05)...Date.new(2018,11,20)))).must_equal TRUE
      # # - Ends on the checkin date
      expect(room5.available?((Date.new(2018,10,12)...Date.new(2018,10,18)))).must_equal TRUE
      # # - Starts on the checkout date (edited)
      expect(room5.available?((Date.new(2018,10,22)...Date.new(2018,10,24)))).must_equal TRUE
    end
  end



end
