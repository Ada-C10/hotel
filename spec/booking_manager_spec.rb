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
    Block.new('181202', '181203', 4)
  }
  let(:block5) {
    Block.new('181202', '181206', 5)
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
      # manager.add_block(block3)
      # manager.add_block(block4)
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

  describe "#add_block" do
    before do
      manager.add_reservation(reservation1)
      manager.add_reservation(reservation2)
      manager.add_reservation(reservation3)
      manager.add_reservation(reservation4)
      manager.add_reservation(reservation5)
      manager.add_block(block2)
      manager.add_block(block4)
      # binding.pry
    end
    it "returns array of block rooms" do
      expect(manager.add_block(block3)).must_equal [1, 2, 3]
    end
    it "adds rooms to block object" do
      manager.add_block(block3)
      expect(block3.rooms.keys).must_equal [1, 2, 3]
      expect(block3.rooms.values).must_equal [:available, :available, :available]
    end
    it "adds all reservation dates to all block rooms" do
      # binding.pry
      expect(calendar.room_assignments[4][0]).must_equal block2.get_all_dates
      expect(calendar.room_assignments[5][0]).must_equal block2.get_all_dates
    end
    it "adds block dates as array" do
      before = calendar.room_assignments[1].length
      # binding.pry
      # binding.pry
      manager.add_block(block3)
      expect(calendar.room_assignments[1].length).must_equal before + 1
      expect(calendar.room_assignments[1].include? block3.get_all_dates).must_equal true
    end
    it "searches block dates" do
      expect(calendar.room_assignments[4].include? block4.get_all_dates).must_equal false
    end
  end
  describe "#reserve_block_room" do
    before do
      manager.add_reservation(reservation1)
    end
    it "reserves first available room in a block" do
      manager.add_block(block2)
      expect(manager.reserve_block_room(block2)).must_equal 2
      expect(block2.rooms[2]).must_equal :unavailable
    end
    it "reserves last available room in a block" do
      manager.add_block(block2)
      manager.reserve_block_room(block2)
      # binding.pry
      expect(manager.reserve_block_room(block2)).must_equal 3
      expect(block2.rooms[3]).must_equal :unavailable
    end
    it "returns 'no rooms' message if block is full" do
      manager.add_block(block2)
      2.times do
        manager.reserve_block_room(block2)
      end
      expect(manager.reserve_block_room(block2)).must_equal "No available rooms in block."
    end
  end
end
  # end
  # end
