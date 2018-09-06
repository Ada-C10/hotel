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
  end

  describe "Room#available?" do
    before do
      room.add_booking(reservation)
      room2.add_booking(reservation2)
    end

    it "returns true/false if room is available for given date range" do
      expect(room.available?(Date.new(2018,10,19), Date.new(2018,10,21)).must_equal False
      expect(room.available?(Date.new(2018,10,22), Date.new(2018,10,24)).must_equal True
    end
  end


end
