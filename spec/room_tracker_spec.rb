require_relative 'spec_helper'

describe Room_Tracker do

  describe "Room_Tracker instantiation" do
    describe "#initialize" do
      it "can create new instance of room_tracker" do

        room_tracker = Room_Tracker.new()

        expect(room_tracker).must_be_instance_of Room_Tracker

      end
    end
  end

  describe "Reservation instantiation with room" do
    let (:start_date) { Date.parse('2012-02-01') }
    let (:end_date) { Date.parse('2012-02-03') }
    let (:room) { 12 }
    bookings = []
    describe "#initialize" do
      it "make_reservation puts room in @bookings array" do
        new_bookings = Reservation.new(start_date,end_date, room)
        bookings << new_bookings
        expect(new_bookings.room).must_equal 12
      end
    end

    describe "rooms array with 20 rooms created" do
      it "creates array of 20 rooms" do
        Room_Tracker.new()
        rooms = []
        room = get_rooms(20)
        rooms <<room
      expect (rooms.length).must_equal 20
    end
  end

  describe "I can access the list of all of the rooms in the hotel" do
    describe "#get_rooms" do
    it "lists all hotel rooms" do
    end
  end
end

  describe "I can reserve a room for a given date range" do
    describe "#make_reservation" do
      let (:start_date) { Date.parse('2012-02-01') }
      let (:end_date) { Date.parse('2012-02-03') }
      let (:room) { [14] }
      let (:bookings) {[]}
             it "assigns available room" do
               hotel = Room_Tracker.new()
               hotel.make_reservation(start_date,end_date)
               new_reservation = hotel.bookings.last
               #new_booking = make_reservation(start_date,end_date, room)# new_bookings = Reservation.new(start_date,end_date, 12)
               expect (new_reservation.room).must_equal 14
        end
        end
      end

      describe "Access the list of reservations for a specific date" do
        describe "#find_reservations_by_date" do
        end
      end

      describe "View a list of rooms that are not reserved for a given date range" do
        describe "#rooms_available_by_date" do
        end
        end

        describe "Reserve an available room for a given date range" do
          describe "#rooms_available_by_date" do
          end
        end

  end
end
