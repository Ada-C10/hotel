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

  describe "#reserve_room" do
    before do
      manager.reserve_room('181202','181204')
    end
    it "increases length of @reservations array" do
      before = manager.reservations.length
      manager.reserve_room('181202','181204')
      expect(manager.reservations.length).must_equal before + 1
    end
    it "adds accurate Reservation instance to array" do
      expect(manager.reservations.first[0]).must_be_kind_of Reservation
      expect(manager.reservations.first[0].check_in).must_equal Date.parse('181202')
      expect(manager.reservations.first[0].check_out).must_equal Date.parse('181204')
    end
    it "adds accurate reservation room number to array" do
      expect(manager.reservations.first[1]).must_equal 1
    end
  end

  describe "#reserve_block" do
    before do
      manager.reserve_block('181202','181204', 2)
      @first_block = manager.blocks[0]
    end
    it "increases length of @blocks array" do
      before = manager.blocks.length
      manager.reserve_block('181202','181204', 2)
      expect(manager.blocks.length).must_equal before + 1
    end
    it "adds accurate Block instance to array" do
      expect(@first_block).must_be_kind_of Block
      expect(@first_block.check_in).must_equal Date.parse('181202')
      expect(@first_block.check_out).must_equal Date.parse('181204')
      expect(@first_block.rooms.length).must_equal 2
    end
  end

  describe "#reserve_block_room" do
    before do
      calendar.add_reservation(reservation1)
      calendar.add_block(block2)
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
