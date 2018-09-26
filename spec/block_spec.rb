# Jacquelyn Cheng - Nodes

# Tests for block.rb

require 'date'
require_relative 'spec_helper.rb'

describe "Block" do
  before do
    @bookingsystem = Hotel::BookingSystem.new
    @checkin_date = Date.parse("2019-02-01")
    @checkout_date = Date.parse("2019-02-05")
    @block_name = "Jackie's Event"
    @room_quantity = 3
  end

  let (:block) {
    @bookingsystem.block_rooms(@block_name, @checkin_date, @checkout_date, room_quantity: @room_quantity)
  }

  describe "Block#initialize" do
    it "instantiates a Block object" do
      expect(block).must_be_instance_of Hotel::Block
    end

    it "has a start date" do
      expect(block.checkin).must_equal @checkin_date
    end

    it "has an end date" do
      expect(block.checkout).must_equal @checkout_date
    end

    it "has a block name" do
      expect(block.block_name).must_equal @block_name
    end

    it "has a discount rate that is 175.00" do
      expect(block.discount_rate).must_equal 175.00
      expect(block.discount_rate).must_be_kind_of Float
    end

    it "initially has available rooms and no booked rooms" do
      expect(block.num_rooms_available).must_equal @room_quantity
      expect(block.num_rooms_booked).must_equal 0
    end
  end

  describe "Block#reserve_from_block" do
    let (:res) {
      block.reserve_from_block(@checkin_date, @checkout_date)
    }

    it "returns a reservation with itself in the block attribute" do
      expect(res).must_be_instance_of Hotel::Reservation
      expect(res.block).must_equal block
    end

    it "returns a reservation with dates that match the block" do
      expect(res.checkin).must_equal block.checkin
      expect(res.checkout).must_equal block.checkout
    end

    it "updates available rooms and booked rooms" do
      expect(block.num_rooms_available).must_equal 3
      expect(block.num_rooms_booked).must_equal 0
      res
      expect(block.num_rooms_available).must_equal 2
      expect(block.num_rooms_booked).must_equal 1
    end

    it "raises an error if dates requested don't match block" do
      expect{block.reserve_from_block(@checkin_date, @checkout_date.next_day)}.must_raise Hotel::Block::InvalidBlockError
    end

    it "raises an error if no rooms available" do
      expect{ (@room_quantity + 1).times do
        block.reserve_from_block(@checkin_date, @checkout_date)
      end }.must_raise Hotel::RoomAvailabilityError
    end
  end
end
