require_relative 'spec_helper'
require 'pry'

describe BookingManager do
  let(:calendar) {
    Calendar.new(20)
  }
  let(:manager) {
    BookingManager.new(calendar)
  }
  let(:reservation1) {
    Reservation.new('181202', '181204')
  }
  let(:reservation2) {
    Reservation.new('181204', '181206')
  }
  let(:reservation3) {
    Reservation.new('181203', '181204')
  }
  let(:reservation4) {
    Reservation.new('181130', '181202')
  }
  let(:reservation5) {
    Reservation.new('181130', '181206')
  }


  describe "#initialize" do
    it "can be instantiated" do
      expect(manager).must_be_kind_of BookingManager
    end
  end



  describe "#add_reservation" do
    before do
      manager.add_reservation(reservation1)
      manager.add_reservation(reservation2)
      manager.add_reservation(reservation3)
      manager.add_reservation(reservation4)
      manager.add_reservation(reservation5)
    end
    it "returns 'Added!' message" do
      expect(manager.add_reservation(reservation1)).must_equal "Added!"
    end
    it "adds all reservation dates to first available room" do
      expect(calendar.room_assignments[1]).must_equal reservation1.get_all_dates + reservation2.get_all_dates + reservation4.get_all_dates
      expect(calendar.room_assignments[2]).must_equal reservation3.get_all_dates
      expect(calendar.room_assignments[3]).must_equal reservation5.get_all_dates
    end
  end



end
# end
