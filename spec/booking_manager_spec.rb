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
  let(:block2) {
    Block.new('181202', '181206', 2)
  }
  let(:block3) {
    Block.new('181206', '181210', 3)
  }
  let(:block4) {
    Block.new('181202', '181206', 4)
  }
  let(:block5) {
    Block.new('181202', '181206', 5)
  }
  before do
    manager.add_reservation(reservation1)
    manager.add_reservation(reservation2)
    manager.add_reservation(reservation3)
    manager.add_reservation(reservation4)
    manager.add_reservation(reservation5)
  end
  describe "#initialize" do
    it "can be instantiated" do
      expect(manager).must_be_kind_of BookingManager
    end
  end

  describe "#add_reservation" do
    it "returns 'Added!' message" do
      expect(manager.add_reservation(reservation1)).must_equal "Added!"
    end
    it "adds all reservation dates to first available room" do
      expect(calendar.room_assignments[1]).must_equal reservation1.get_all_dates + reservation2.get_all_dates + reservation4.get_all_dates
      expect(calendar.room_assignments[2]).must_equal reservation3.get_all_dates
      expect(calendar.room_assignments[3]).must_equal reservation5.get_all_dates
    end
  end

  describe "#add_block" do
    it "returns 'Added!' message" do
      expect(manager.add_block(block2)).must_equal "Added!"
    end
    it "adds all reservation dates to all block rooms" do
      manager.add_block(block2)
      # binding.pry
      expect(calendar.room_assignments[4][0]).must_equal block2.get_all_dates
      expect(calendar.room_assignments[5][0]).must_equal block2.get_all_dates
    end
    it "adds block dates as array" do
      before = calendar.room_assignments[1].length
      # binding.pry
      manager.add_block(block3)
      # binding.pry
      expect(calendar.room_assignments[1].length).must_equal before + 1
      expect(calendar.room_assignments[1].include? block3.get_all_dates).must_equal true
    end
  end
end
  # end
  # end
