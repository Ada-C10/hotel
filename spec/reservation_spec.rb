# Jacquelyn Cheng - Nodes

# Tests for reservation.rb

require 'date'
require_relative 'spec_helper.rb'

describe "Reservation" do
  before do
    @checkin_date = Date.parse("2019-02-01")
    @checkout_date = Date.parse("2019-02-05")
    @conf_num = 10
  end

  let (:res) {
    Hotel::Reservation.new(@checkin_date, @checkout_date, @conf_num)
  }

  let (:room1) {
    Hotel::Room.new(1, Date.parse("2019-01-01"), Date.parse("2019-12-31"))
  }

  describe "Reservation#initialize" do
    it "instantiates a Reservation object" do
      expect(res).must_be_instance_of Hotel::Reservation
    end

    it "has a start date" do
      expect(res.checkin_date).must_equal @checkin_date
    end

    it "has an end date" do
      expect(res.checkout_date).must_equal @checkout_date
    end

    it "initially has an empty collection of rooms" do
      expect(res.rooms.length).must_equal 0
      expect(res.rooms).must_be_kind_of Enumerable
    end

    it "has a confirmation number" do
      expect(res.confirmation_number).must_equal @conf_num
    end
  end

  describe "Reservation#add_room" do
    it "updates the room's status" do
      expect(room1.is_available? @checkin_date).must_equal true
      expect(room1.is_available? @checkout_date.prev_day).must_equal true
      res.add_room(room1)
      expect(room1.is_available? @checkin_date).must_equal false
      expect(room1.is_available? @checkout_date.prev_day).must_equal false
    end

    it "checkout_date availability is unmodified" do
      expect(room1.is_available? @checkout_date).must_equal true
      res.add_room(room1)
      expect(room1.is_available? @checkout_date).must_equal true
    end

    it "adds a room to reservation @rooms" do
      expect(res.rooms.length).must_equal 0
      res.add_room(room1)
      expect(res.rooms.length).must_equal 1
      expect(res.rooms.first).must_be_instance_of Hotel::Room
    end

    it "raises an error if Room object is not provided" do
      expect{res.add_room(4)}.must_raise ArgumentError
    end

    it "raises an error if Room object is already on reservation" do
      res.add_room(room1)
      expect{res.add_room(room1)}.must_raise ArgumentError
    end
  end

  describe "Resevation#total_cost" do
    before do
      res.add_room(room1)
    end

    it "returns a float" do
      expect(res.total_cost).must_be_instance_of Float
    end

    it "correctly calculates cost to two decimal places based on # of nights" do
      expect(res.total_cost).must_equal 800.00
    end
  end
end
