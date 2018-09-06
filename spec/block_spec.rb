# Jacquelyn Cheng - Nodes

# Tests for block.rb

require 'date'
require_relative 'spec_helper.rb'

describe "Block" do
  before do
    @checkin_date = Date.parse("2019-02-01")
    @checkout_date = Date.parse("2019-02-05")
    @discount_rate = 150.00
    @block_name = "Jackie's Event"
  end

  let (:block) {
    Hotel::Block.new(@checkin_date, @checkout_date, @block_name, @discount_rate)
  }

  let (:room1) {
    Hotel::Room.new(1, Date.parse("2019-01-01"), Date.parse("2019-12-31"))
  }

  let (:res1) {
    res1 = Hotel::Reservation.new(@checkin_date, @checkout_date, @conf_num)
    res1.add_room(room1)
    res1
  }

  describe "Block#initialize" do
    it "instantiates a Block object" do
      expect(block).must_be_instance_of Hotel::Block
    end

    it "has a start date" do
      expect(block.checkin_date).must_equal @checkin_date
    end

    it "has an end date" do
      expect(block.checkout_date).must_equal @checkout_date
    end

    it "has a block name" do
      expect(block.block_name).must_equal @block_name
    end

    it "has a discount rate that is a float" do
      expect(block.discount_rate).must_equal @discount_rate
      expect(block.discount_rate).must_be_kind_of Float
    end

    it "initially has an empty collection of blocked rooms" do
      expect(block.blocked_rooms.length).must_equal 0
      expect(block.blocked_rooms).must_be_kind_of Enumerable
    end

    it "initially has an empty collection of reservations" do
      expect(block.reservations.length).must_equal 0
      expect(block.reservations).must_be_kind_of Enumerable
    end

  end

  describe "Block#add_room" do
    it "updates the room's status" do
      expect(room1.is_available? @checkin_date).must_equal true
      expect(room1.is_available? @checkout_date.prev_day).must_equal true
      block.add_room(room1)
      expect(room1.is_available? @checkin_date).must_equal false
      expect(room1.is_available? @checkout_date.prev_day).must_equal false
    end

    it "checkout_date availability is unmodified" do
      expect(room1.is_available? @checkout_date).must_equal true
      block.add_room(room1)
      expect(room1.is_available? @checkout_date).must_equal true
    end

    it "adds a room to block @blocked_rooms" do
      expect(block.blocked_rooms.length).must_equal 0
      block.add_room(room1)
      expect(block.blocked_rooms.length).must_equal 1
      expect(block.blocked_rooms.first).must_be_instance_of Hotel::Room
    end

    it "raises an error if Room object is not provided" do
      expect{block.add_room(4)}.must_raise ArgumentError
    end

    it "raises an error if Room object is already in block" do
      block.add_room(room1)
      expect{block.add_room(room1)}.must_raise ArgumentError
    end

    it "raises an error if 5 rooms already blocked" do
      block.add_room(room1)
      block.add_room(Hotel::Room.new(2, Date.parse("2019-01-01"), Date.parse("2019-12-31")))
      block.add_room(Hotel::Room.new(3, Date.parse("2019-01-01"), Date.parse("2019-12-31")))
      block.add_room(Hotel::Room.new(4, Date.parse("2019-01-01"), Date.parse("2019-12-31")))
      block.add_room(Hotel::Room.new(5, Date.parse("2019-01-01"), Date.parse("2019-12-31")))
      expect{block.add_room(Hotel::Room.new(6, Date.parse("2019-01-01"), Date.parse("2019-12-31")))}.must_raise ArgumentError
    end
  end

  describe "Block#add_reservation" do
    it "adds a reservation to block @reservations" do
      expect(block.reservations.length).must_equal 0
      block.add_reservation(res1)
      expect(block.reservations.length).must_equal 1
      expect(block.reservations.first).must_be_instance_of Hotel::Reservation
    end

    it "removes a room from block @blocked_rooms" do
      block.add_room(room1)
      expect(block.blocked_rooms.length).must_equal 1
      block.add_reservation(res1)
      expect(block.blocked_rooms.length).must_equal 0
    end

    it "raises an error if Reservation object is not provided" do
      expect{block.add_reservation(4)}.must_raise ArgumentError
    end

    it "raises an error if Reservation object is already in block" do
      block.add_reservation(res1)
      expect{block.add_reservation(res1)}.must_raise ArgumentError
    end
  end
end
