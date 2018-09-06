require_relative 'spec_helper'

describe "Room" do
  let (:room) {
    Room.new(1)
  }
  let (:room2) {
    Room.new(2)
  }
  let (:reservation) {
    Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: room, date_range: [Date.new(2018,10,20),Date.new(2018,10,22)]})
  }
  let (:reservation2) {
    Reservation.new({guest_id: "Guccifer2.0@ada.com", room: room2 , date_range: [Date.new(2018,12,02),Date.new(2018,12,07)]})
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
      bad_reservation = Reservation.new({guest_id: "TellieTubbie@gmail.com", room: room, date_range: [Date.new(2018,10,20), Date.new(2018,10,21)]})
      room.add_booking(bad_reservation)

      expect{ room.add_booking(bad_reservation)
      }.must_raise ArgumentError

    end
  end

  describe "Room#available?" do
    before do
      room.add_booking(reservation)
    end

    it "returns true/false if room is available for given date range" do
      expect(room.available?(Date.new(2018,10,19), Date.new(2018,10,21))).must_equal FALSE
      expect(room.available?(Date.new(2018,10,22), Date.new(2018,10,24))).must_equal TRUE
    end
  end



end
