require_relative 'spec_helper'
require 'pry'

describe BookingManager do
  let(:calendar) {
    Calendar.new
  }
  let(:manager) {
    BookingManager.new(calendar)
  }
  let(:reservation1) {
    Reservation.new('181202', '181204')
  }
  let(:reservation2) {
    Reservation.new('181203', '181206')
  }
  let(:reservation3) {
    Reservation.new('181205', '181206')
  }
  let(:reservation4) {
    Reservation.new('181204', '181206')
  }

  describe "#initialize" do
    it "can be instantiated" do
      expect(manager).must_be_kind_of BookingManager
    end
  end

  describe "#print_all_rooms" do
    before do
      calendar = Calendar.new
      manager = BookingManager.new(calendar)
    end
    it "returns array" do
      expect(manager.print_all_rooms).must_be_kind_of Array
    end
  end

  describe "#reservation_list" do
    before do
      calendar.add_reservation(reservation1)
      calendar.add_reservation(reservation1)
      calendar.add_reservation(reservation2)
      calendar.add_reservation(reservation3)
      calendar.add_reservation(reservation4)
    end
    it "returns list of reserved rooms for provided date" do
      list = manager.reservation_list('181203')
      expect(list.length).must_equal 3
      expect(list[0]).must_equal 1
      expect(list[2]).must_equal 3
    end


    describe "#print_available_rooms" do
      it "returns available rooms for given date range" do
        available = manager.print_available_rooms('181202', '181204')
        expect(available.length).must_equal 17
      end
    end
  end
end
