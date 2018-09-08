# Jacquelyn Cheng - Nodes

# Tests for admin.rb

require_relative 'spec_helper.rb'

describe "Admin" do
  before do
    @admin = Hotel::Admin.new
  end

  describe "Admin#initialize" do
    it "instantiates a hotel admin" do
      expect(@admin).must_be_instance_of Hotel::Admin
    end

    it "has a list of 20 Room objects" do
      expect(@admin.rooms.length).must_equal 20
      expect(@admin.rooms.first).must_be_instance_of Hotel::Room
      expect(@admin.rooms.last).must_be_instance_of Hotel::Room
    end

    it "has an empty colletion of reservations when initialized" do
      expect(@admin.reservations.length).must_equal 0
    end

    it "has an empty colletion of blocks when initialized" do
      expect(@admin.blocks.length).must_equal 0
    end
  end

  describe "Admin#make_reservation" do
    let (:res1) {
      @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-04"))
    }

    let (:res2) {
      @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-02"), 2)
    }

    it "returns a Reservation with correct reservation dates" do
      expect(res1).must_be_instance_of Hotel::Reservation
      expect(res1.checkin_date).must_be_instance_of Date
      expect(res1.checkin_date.to_s).must_equal "2019-01-01"
      expect(res1.checkout_date).must_be_instance_of Date
      expect(res1.checkout_date.to_s).must_equal "2019-01-04"
    end

    it "assigns a collection of rooms to the Reservation" do
      expect(res1.rooms).must_be_kind_of Enumerable
      expect(res1.rooms.first).must_be_instance_of Hotel::Room
      expect(res2.rooms).must_be_kind_of Enumerable
      expect(res2.rooms.last).must_be_instance_of Hotel::Room
    end

    it "makes the assigned rooms unavailable" do
      res1.checkin_date.upto(res1.checkout_date.prev_day) do |date|
        expect(res1.rooms.first.is_available? date).must_equal false
      end
    end

    it "updates the assigned rooms' availability to :BOOKED" do
      res1.checkin_date.upto(res1.checkout_date.prev_day) do |date|
        expect(res1.rooms.first.availability[date.to_s][:status]).must_equal :BOOKED
      end
    end

    it "raises an exception if provided end date before start date" do
      expect{
        @admin.make_reservation(Date.parse("2019-01-04"), Date.parse("2019-01-01"))
      }.must_raise ArgumentError
    end

    it "raises an exception if no rooms are available for dates selected" do
      expect{
        21.times do
          @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-04"))
        end
      }.must_raise Hotel::RoomAvailabilityError
    end

    it "can reserve a room from within a block of rooms at a discounted rate" do
      new_block = @admin.make_block("Jackie's Event", Date.parse("2019-02-01"), Date.parse("2019-02-05"), 150.00, 3)
      expect(new_block.num_rooms_available).must_equal 3
      new_res = @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-02"), 2, new_block)
      expect(new_block.num_rooms_available).must_equal 1
      expect(new_res.block).must_equal new_block
      expect(new_res.block.discount_rate).must_equal new_block.discount_rate
    end
  end

  describe "Admin#list_reservations" do
    it "returns a list of all reservations on a specific date" do
      10.times do
        @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-04"))
      end
      expect(@admin.list_reservations(Date.parse("2019-01-01")).length).must_equal 10
    end
  end

  describe "Admin#list_available_rooms" do
    it "returns a list of available rooms for a given date" do
      @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-02"))
      @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-04"))
      expect(@admin.list_available_rooms(Date.parse("2019-01-01")).length).must_equal 2
      expect(@admin.list_available_rooms(Date.parse("2019-01-03")).length).must_equal 1
    end
  end

  describe "Admin#make_block" do
    before do
      @block_name = "Jackie's Event"
      @checkin_date = Date.parse("2019-02-01")
      @checkout_date = Date.parse("2019-02-05")
      @discount_rate = 150.00
      @room_quantity = 5
    end

    let (:block) {
      @admin.make_block(@block_name, @checkin_date, @checkout_date, @discount_rate, @room_quantity)
    }

    it "returns a Block with correct reservation dates" do
      expect(block).must_be_instance_of Hotel::Block
      expect(block.checkin_date).must_be_instance_of Date
      expect(block.checkin_date.to_s).must_equal "2019-02-01"
      expect(block.checkout_date).must_be_instance_of Date
      expect(block.checkout_date.to_s).must_equal "2019-02-05"
    end

    it "assigns a collection of rooms to the Block" do
      expect(block.blocked_rooms).must_be_kind_of Enumerable
      expect(block.blocked_rooms.first).must_be_instance_of Hotel::Room
      expect(block.blocked_rooms.last).must_be_instance_of Hotel::Room
      expect(block.blocked_rooms.length).must_equal 5
    end

    it "makes the assigned rooms unavailable" do
      block.checkin_date.upto(block.checkout_date.prev_day) do |date|
        expect(block.blocked_rooms.first.is_available? date).must_equal false
        expect(block.blocked_rooms.last.is_available? date).must_equal false
      end
    end

    it "updates the assigned rooms' availability to :BLOCKED" do
      block.checkin_date.upto(block.checkout_date.prev_day) do |date|
        expect(block.blocked_rooms.first.availability[date.to_s][:status]).must_equal :BLOCKED
        expect(block.blocked_rooms.last.availability[date.to_s][:status]).must_equal :BLOCKED
      end
    end

    it "raises an exception if provided end date before start date" do
      expect{
        @admin.make_block(@block_name, @checkout_date, @checkin_date, @discount_rate, @room_quantity)
      }.must_raise ArgumentError
    end

    it "raises an exception if no rooms are available for dates selected" do
      expect{
        5.times do
          @admin.make_block(@block_name, @checkin_date, @checkout_date, @discount_rate, @room_quantity)
        end
      }.must_raise Hotel::RoomAvailabilityError
    end
  end

  describe "Admin#find_reservation" do
    it "returns nil if no reservation found" do
      expect(@admin.find_reservation(10)).must_be_nil
    end

    it "returns the reservation with the corresponding confirmation number if found" do
      @admin.make_reservation(Date.parse("2019-02-01"), Date.parse("2019-02-05"))
      expect(@admin.find_reservation(1)).must_be_instance_of Hotel::Reservation
      expect(@admin.find_reservation(1).confirmation_number).must_equal 1
      expect(@admin.find_reservation(1).rooms.first).must_be_instance_of Hotel::Room
      expect(@admin.find_reservation(1).checkin_date).must_equal Date.parse("2019-02-01")
    end
  end

  describe "Admin#find_block" do
    it "returns nil if no block found" do
      expect(@admin.find_block("Johnson Wedding")).must_be_nil
    end

    it "returns the block with the corresponding block name if found" do
      @admin.make_block("Jackie's Event", Date.parse("2019-02-01"), Date.parse("2019-02-05"), 150.00, 3)
      expect(@admin.find_block("Jackie's Event")).must_be_instance_of Hotel::Block
      expect(@admin.find_block("Jackie's Event").block_name).must_equal "Jackie's Event"
      expect(@admin.find_block("Jackie's Event").discount_rate).must_equal 150.00
    end
  end
end
