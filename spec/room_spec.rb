require_relative 'spec_helper'

describe "Room" do
  let (:room) {
    Hotel::Room.new(1)
  }
  let (:room2) {
    Hotel::Room.new(2)
  }
  let (:reservation) {
    Hotel::Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: 1, date_range: (Date.new(2018,10,18)..Date.new(2018,10,22))})
  }
  let (:reservation2) {
    Hotel::Reservation.new({guest_id: "Guccifer2.0@ada.com", room: 2 , date_range: (Date.new(2018,12,02)..Date.new(2018,12,07))})
  }

  describe "Room#initialize" do
    it "can create a room object" do
      expect(room).must_be_instance_of Hotel::Room
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
      expect(room.bookings[0]).must_be_instance_of Hotel::Reservation
    end

    it "will raise an exception if a conflicting reservation is added to a room" do
      bad_reservation = Hotel::Reservation.new({guest_id: "TellieTubbie@gmail.com", room: 2, date_range: (Date.new(2018,12,02)..Date.new(2018,12,04))})
      room2.add_booking(bad_reservation)

      expect{ room2.add_booking(bad_reservation)
      }.must_raise ArgumentError

    end
  end

  describe "Room#available?" do
    let (:room5) {
      Hotel::Room.new(5)
    }
    let (:reservation3) {
      Hotel::Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: 5, date_range: (Date.new(2018,10,18)...Date.new(2018,10,22))})
    }

    it "returns true/false if room is available for given date range" do

      room5.add_booking(reservation3)
      #Test cases provided by Dan on Slack
      #Two date ranges *do* overlap if range A compared to range B:
      #Same dates
      expect(room5.available?((Date.new(2018,10,18)...Date.new(2018,10,22)))).must_equal FALSE
      #overlaps in the front
      expect(room5.available?((Date.new(2018,10,15)...Date.new(2018,10,19)))).must_equal FALSE
      #overlaps in the back
      expect(room5.available?((Date.new(2018,10,21)...Date.new(2018,10,22)))).must_equal FALSE
      #Completely contained
      expect(room5.available?((Date.new(2018,10,19)...Date.new(2018,10,20)))).must_equal FALSE
      #Completely containing
      expect(room5.available?((Date.new(2018,10,17)...Date.new(2018,10,23)))).must_equal FALSE

      #Two date ranges are *not* overlapping if range A compared to range B:
      #Completely before
      expect(room5.available?((Date.new(2018,07,05)...Date.new(2018,07,07)))).must_equal TRUE
      #Completely after
      expect(room5.available?((Date.new(2018,11,05)...Date.new(2018,11,20)))).must_equal TRUE
      #Ends on the checkin date
      expect(room5.available?((Date.new(2018,10,12)...Date.new(2018,10,18)))).must_equal TRUE
      #Starts on the checkout date (edited)
      expect(room5.available?((Date.new(2018,10,22)...Date.new(2018,10,24)))).must_equal TRUE
    end
  end

  describe "Room#find_bookings" do
    let (:reservation8) {
      Hotel::Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: 8, date_range: (Date.new(2018,10,18)...Date.new(2018,10,22))})
    }

    it "returns an array of booking for a given date" do
      room8 = Hotel::Room.new(8)
      room8.add_booking(reservation8)

      expect(room8.find_bookings(Date.new(2018,10,18))).must_be_instance_of Array
      expect(room8.find_bookings(Date.new(2018,10,18)).first).must_be_instance_of Hotel::Reservation
      expect(room8.find_bookings(Date.new(2018,10,18)).first.date_range).must_equal (Date.new(2018,10,18)...Date.new(2018,10,22))
    end
  end

  describe "Room#available_in_block" do
    let (:hotel) {
       Hotel::HotelAdmin.new
    }

    it "returns true or false based on whether there are rooms available to reserve in block" do
      hotel.reserve_block("La Bomba", [11,12], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)
      room11 = hotel.retrieve_room(11)
      hotel.reserve_room_in_block("La Bomba", 11)
      room12 = hotel.retrieve_room(12)

      expect(room11.available_in_block("La Bomba")).must_equal false
      expect(room12.available_in_block("La Bomba")).must_equal true
    end
  end

end
