require_relative 'spec_helper'

describe Calendar do
  describe "#initalize" do
    it "can be instantiated" do
      calendar = Calendar.new
      expect(calendar).must_be_kind_of Calendar
    end
    it "stores rooms constant" do
      expect(Calendar::ROOMS).must_be_kind_of Array
      expect(Calendar::ROOMS[0]).must_equal 1
    end
  end
  describe "#add_reservation" do
    it "increases length of @reservations" do
      calendar = Calendar.new
      reservation = Reservation.new(181202, 2)
      calendar.add_reservation(reservation)
      expect(calendar.reservations.length).must_equal 1
    end
  end
end
