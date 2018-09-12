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
    describe "#make_reservation" do
             it "assigns available room" do
               Room_Tracker.new()
    
               expect (Room_Tracker.make_reservation.room).must_equal 14
        end
        end
  end


end
