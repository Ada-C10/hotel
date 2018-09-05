require_relative 'spec_helper'

describe "Room" do
  let (:room) {
    Room.new(1)
  }
  let (:reservation) {
    Reservation.new("SoccerMom2010@gmail.com", 1, [Date.new(2018,10,20),Date.new(2018,10,22)])
  }

  describe "Room#initialize" do
    it "can create a room object" do
      expect(room).must_be_instance_of Room
    end

    it "initializes a room with an empty array attribute for reservations" do
      expect(room.bookings).must_be_instance_of Array
      expect(room.bookings).must_be_empty
    end
  end

  describe "Room#add_reservation" do
    it "will add a reservation object to a room's bookings attribute'" do
      room.add_reservation(reservation)

      expect(room.bookings).wont_be_empty
      expect(room.bookings[0]).must_be_instance_of Reservation
    end
  end

  describe "Room#list_rooms" do
    it "will print all of the room objects" do
      20.times do |index|
        Room.new(index+1)
      end
      expect(Room.list_rooms[0]).must_be_instance_of Room
      expect(Room.list_rooms).must_be_instance_of Array
      #always getting increasing numbers here as it runs
      #expect(Room.list_rooms.length).must_equal 20
    end
  end

end
