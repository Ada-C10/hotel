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
  let(:block6) {
    Block.new('181203', '181205', 2)
  }
  let(:block7) {
    Block.new('181206', '181208', 5)
  }
  describe "#initialize" do
    it "can be instantiated" do
      expect(manager).must_be_kind_of BookingManager
    end
    it "takes a calendar" do
      expect(manager.calendar).must_be_kind_of Calendar
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
    it "adds all reservation dates to first available room" do
      expect(calendar.room_assignments[1]).must_equal reservation1.get_all_dates + reservation2.get_all_dates + reservation4.get_all_dates

      expect(calendar.room_assignments[2]).must_equal reservation3.get_all_dates

      expect(calendar.room_assignments[3]).must_equal reservation5.get_all_dates
    end
    it "returns assigned room" do
      expect(manager.add_reservation(reservation1)).must_equal 4
    end
    it "raises exception if no rooms available" do
      17.times do
        manager.add_reservation(reservation1)
      end
      expect{manager.add_reservation(reservation1)}.must_raise StandardError
    end
    it "correctly adds reservation dates when blocks are on calendar" do
      manager.add_block(block2)

      expect(manager.add_reservation(reservation3)).must_equal 6
      expect(calendar.room_assignments[6]).must_equal reservation3.get_all_dates
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
    end
    it "returns array of block rooms" do
      expect(manager.add_block(block3)).must_equal [1, 2, 3]
    end
    it "raises exception if not enough available rooms" do
      4.times do
        manager.add_block(block7)
      end

      expect{manager.add_block(block7)}.must_raise StandardError
    end
    it "adds rooms hash to block object" do
      manager.add_block(block3)

      expect(block3.rooms).must_be_kind_of Hash
      expect(block3.rooms.keys).must_equal [1, 2, 3]
      expect(block3.rooms.values).must_equal [:available, :available, :available]
    end
    it "adds block dates to calendar as array" do
      before = calendar.room_assignments[1].length

      manager.add_block(block3)

      expect(calendar.room_assignments[1].length).must_equal before + 1
      expect(calendar.room_assignments[1].length).wont_equal before + block3.get_all_dates.length
      expect(calendar.room_assignments[1].include? block3.get_all_dates).must_equal true
    end
    it "adds all reservation dates to all block rooms" do
      expect(calendar.room_assignments[4][0]).must_equal block2.get_all_dates
      expect(calendar.room_assignments[4][0].length).must_equal block2.number_of_nights
      expect(calendar.room_assignments[5][0]).must_equal block2.get_all_dates
      expect(calendar.room_assignments[5][0].length).must_equal block2.number_of_nights
    end
  end

  describe "#reserve_block_room" do
    before do
      manager.add_reservation(reservation1)
      manager.add_block(block2)
    end
    it "returns reserved room if block isn't full" do
      expect(manager.reserve_block_room(block2)).must_equal 2
    end
    it "raises exception if block is full" do
      2.times do
        manager.reserve_block_room(block2)
      end

      expect{manager.reserve_block_room(block2)}.must_raise StandardError
    end
    it "reserves first available room in a block" do
      expect(manager.reserve_block_room(block2)).must_equal 2
      expect(block2.rooms[2]).must_equal :unavailable
    end
    it "reserves last available room in a block" do
      manager.reserve_block_room(block2)
      
      expect(manager.reserve_block_room(block2)).must_equal 3
      expect(block2.rooms[3]).must_equal :unavailable
    end
  end
end
