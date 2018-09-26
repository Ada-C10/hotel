# Jacquelyn Cheng - Nodes

# Tests for reservation.rb

require 'date'
require_relative 'spec_helper.rb'

describe "Reservation" do
  before do
    @checkin_date = Date.parse("2019-02-01")
    @checkout_date = Date.parse("2019-02-05")
  end

  let (:room1) {
    Hotel::Room.new(1)
  }

  let (:res) {
    Hotel::Reservation.new(@checkin_date, @checkout_date, room1)
  }

  describe "Reservation#initialize" do
    it "instantiates a Reservation object" do
      expect(res).must_be_instance_of Hotel::Reservation
    end

    it "has a start date" do
      expect(res.checkin).must_equal @checkin_date
    end

    it "has an end date" do
      expect(res.checkout).must_equal @checkout_date
    end

    it "has a room assigned" do
      expect(res.room).must_be_kind_of Hotel::Room
    end

    it "defaults to 200.00 room rate" do
      expect(res.rate).must_equal 200.00
    end

    it "defaults to nil block" do
      expect(res.block).must_be_nil
    end
  end

  describe "Reservation#total_cost" do
    before do
      @bookingsystem = Hotel::BookingSystem.new
    end

    let (:res1) {
      @bookingsystem.reserve_room(@checkin_date, @checkout_date)
    }

    it "returns a float" do
      expect(res1.total_cost).must_be_instance_of Float
    end

    it "correctly calculates cost to two decimal places based on # of nights" do
      expect(res1.total_cost).must_equal 800.00
    end

    it "correctly calculates the cost for a discounted room in a block" do
      block = @bookingsystem.block_rooms("Jackie's Event", Date.parse("2019-02-01"), Date.parse("2019-02-05"), room_quantity: 3)
      res2 = @bookingsystem.reserve_room(Date.parse("2019-02-01"), Date.parse("2019-02-05"), block: block)
      expect(res2.total_cost).must_equal 175.00 * 4
    end
  end
end
