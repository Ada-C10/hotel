require_relative 'spec_helper'
require 'pry'
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
    # it "increases length of @reservations" do
    #   calendar = Calendar.new
    #   reservation = Reservation.new(181202, 2)
    #   calendar.add_reservation(reservation)
    #   expect(calendar.reservations.length).must_equal 1
    # end
    it "adds reservation to first empty room" do
      calendar = Calendar.new
      reservation = Reservation.new(181202, 2)
      reservation2 = Reservation.new(181102, 3)
      # 20.times do
      calendar.add_reservation(reservation)
      calendar.add_reservation(reservation2)
      # end
      binding.pry
      expect(calendar.room_assignments[1][0]).must_be_kind_of Date
      expect(calendar.room_assignments[1][0]).wont_equal calendar.room_assignments[2][0]
      # calendar.room_assignments.each do |k, v|
      #   expect(v.empty?).must_equal false
    end
  end
end
# end
