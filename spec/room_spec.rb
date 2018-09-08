# Jacquelyn Cheng - Nodes

# Tests for room.rb

require_relative 'spec_helper.rb'

AVAILABLE_STARTING = Date.parse("2019-01-01")
AVAILABLE_THRU = Date.parse("2019-12-31")

describe "Room class" do
  let (:room) {
    Hotel::Room.new(1, AVAILABLE_STARTING, AVAILABLE_THRU)
  }

  describe "Room#initialize" do
    it "instantiates a Room object" do
      expect(room).must_be_instance_of Hotel::Room
    end

    it "has a room number" do
      expect(room.room_num).must_equal 1
    end

    it "must start out as available for all dates in 2019" do
      expect(room.is_available?(Date.parse("2019-01-01"))).must_equal true
      expect(room.is_available?(Date.parse("2019-09-01"))).must_equal true
      expect(room.is_available?(Date.parse("2019-12-31"))).must_equal true
    end

    it "must only make dates in the range provided available" do
      expect(room.is_available?(Date.parse("2020-01-01"))).must_equal false
    end

    it "defaults to 200.00 for the room rate" do
      expect(room.nightly_rate(AVAILABLE_STARTING)).must_equal 200.00
      expect(room.nightly_rate(AVAILABLE_STARTING)).must_be_instance_of Float
    end
  end

  describe "Room#add_inventory" do
    it "adds new availability to a room" do
      expect(room.is_available?(Date.parse("2020-01-01"))).must_equal false
      room.add_inventory(Date.parse("2020-01-01"), Date.parse("2020-12-31"))
      expect(room.is_available?(Date.parse("2020-01-01"))).must_equal true
    end

    it "must raise an error if called with invalid dates" do
      # start date is after end date
      expect{room.add_inventory(AVAILABLE_THRU, AVAILABLE_STARTING)}.must_raise ArgumentError

      # start date is already available
      expect{room.add_inventory(AVAILABLE_THRU, Date.parse("2020-12-31"))}.must_raise ArgumentError
    end
  end

  describe "Room#change_room_status" do
    it "changes a room's status" do
      expect(room.is_available?(Date.parse("2019-01-02"))).must_equal true
      expect(room.is_available?(Date.parse("2019-02-02"))).must_equal true
      room.change_room_status(Date.parse("2019-01-02"), :BOOKED)
      room.change_room_status(Date.parse("2019-02-02"), :BLOCKED)
      expect(room.is_available?(Date.parse("2019-01-02"))).must_equal false
      expect(room.is_available?(Date.parse("2019-02-02"))).must_equal false
    end

    it "raises an error if given an invalid status" do
      expect{room.change_room_status(AVAILABLE_THRU, :INVALID_STATUS)}.must_raise ArgumentError
    end
  end

  describe "Room#change_nightly_rate" do
    it "changes the nightly rate for a given date" do
      expect(room.nightly_rate(AVAILABLE_STARTING)).must_equal 200.00
      room.change_nightly_rate(AVAILABLE_STARTING, 150.00)
      expect(room.nightly_rate(AVAILABLE_STARTING)).must_equal 150.00
    end

    it "raises an error if new rate is <= 0 or non numeric" do
      expect{room.change_nightly_rate(AVAILABLE_THRU, -10)}.must_raise ArgumentError
      expect{room.change_nightly_rate(AVAILABLE_THRU, "two hundred")}.must_raise ArgumentError
    end
  end

  # TODO ADD TESTS FOR IS AVAILABLE
end
