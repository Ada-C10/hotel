require_relative 'spec_helper'

describe "Reservation class" do
  describe "initialize method" do
    before do
      @manager = Hotel::BookingManager.new(5)
      @room = @manager.rooms.first
    end

    it "creates a new instance of Reservation" do
      new_booking = Hotel::Reservation.new(@room, guest_name: "Tina Fey", start_date: "June 11, 2018", end_date: "June 14, 2018")
      expect(new_booking).must_be_instance_of Hotel::Reservation
    end # of new reservation is new instance it

    it "raises an ArgumentError for an invalid date range" do
      proc {
        booking = Hotel::Reservation.new(@room, guest_name: "Tina Fey", start_date: "June 11, 2018", end_date: "June 10, 2018")
      }.must_raise ArgumentError
      #proc {booking.check_dates(booking.start_date, booking.end_date)}.must_raise ArgumentError
    end # of invalid date range ArgumentError
  end # of initialize method


  describe "get_reservation_cost method" do
    it "returns the total cost of the reservation" do
      hotel = Hotel::BookingManager.new(5)
      room = hotel.rooms.first
      booking = Hotel::Reservation.new(room, guest_name: "Ilona Illari", start_date: "June 10, 2018", end_date: "June 12, 2018")

      expect(booking.get_reservation_cost).must_be_close_to 400
    end
  end

end # of class Reservation
