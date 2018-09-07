require_relative 'spec_helper'
require 'pry'

describe BookingManager do
  before do
    @calendar = Calendar.new
    @manager = BookingManager.new(@calendar)
  end
  describe "#initialize" do
    it "can be instantiated" do
      expect(@manager).must_be_kind_of BookingManager
    end
  end

  describe "#print_all_rooms" do
    before do
      @calendar = Calendar.new
      @manager = BookingManager.new(@calendar)
    end
    it "returns array" do
      expect(@manager.print_all_rooms).must_be_kind_of Array
    end
  end

  describe "#reservation_list and #print_available_rooms" do
    before do
      @calendar = Calendar.new
      @reservation = Reservation.new('181202', '181204')
      @reservation2 = Reservation.new('181202', '181204')
      @reservation3 = Reservation.new('181203', '181206')
      @reservation4 = Reservation.new('181205', '181206')
      @reservation5 = Reservation.new('181204', '181206')
      @calendar.add_reservation(@reservation)
      @calendar.add_reservation(@reservation2)
      @calendar.add_reservation(@reservation3)
      @calendar.add_reservation(@reservation4)
      @calendar.add_reservation(@reservation5)
      @manager = BookingManager.new(@calendar)
      # binding.pry
    end
    it "returns list of reserved rooms for provided date" do
      list = @manager.reservation_list('181203')
      expect(list.length).must_equal 3
      expect(list[0]).must_equal 1
      expect(list[2]).must_equal 3
    end
    it "returns available rooms for given date range" do
      @available = @manager.print_available_rooms('181202', '181204')
      expect(@available.length).must_equal 17
    end

  end
end
