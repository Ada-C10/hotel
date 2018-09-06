# Jacquelyn Cheng - Nodes

# Tests for block.rb

require 'date'
require_relative 'spec_helper.rb'

describe "Block" do
  before do
    @checkin_date = Date.parse("2019-02-01")
    @checkout_date = Date.parse("2019-02-05")
    @discount_rate = 150.00
    @num_rooms = 5
    @conf = 1
    @room_array = [ Hotel::Room.new(1),
              Hotel::Room.new(2),
              Hotel::Room.new(3),
              Hotel::Room.new(4),
              Hotel::Room.new(5) ]
    @admin = Hotel::Admin.new
    @res1 = @admin.make_reservation("2019-01-01", "2019-01-04")
    @res2 = @admin.make_reservation("2019-01-01", "2019-01-02")
  end
  let (:block) {
    Hotel::Block.new("Jackie's Event", @checkin_date, @checkout_date, @discount_rate, @room_array, nil, @conf)
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

    it "has a discount rate that is a float and less than 200" do
      expect(block.nightly_rate).must_equal @discount_rate
      expect(block.nightly_rate < 200).must_equal true
      expect(block.nightly_rate).must_be_kind_of Float
    end

    it "tracks the number of available rooms in the block" do
      expect(block.blocked_rooms_available.length).must_equal @num_rooms
      expect(block.blocked_rooms_booked.length).must_equal 0
      # add reservations TODO
      expect(block.blocked_rooms_available.length).must_equal 0
      expect(block.blocked_rooms_booked.length).must_equal @num_rooms
    end

    it "has a collection of rooms assigned" do
      # need to add rooms TODO
      expect(block.rooms.first).must_be_instance_of Hotel::Room
    end

    it "has a confirmation number" do
      expect(block.confirmation_number).must_equal @conf
    end
  end
end
