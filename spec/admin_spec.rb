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

    it "has an empty collection of reservations when initialized" do
      expect(@admin.reservations.length).must_equal 0
    end

    it "has an empty collection of blocks when initialized" do
      expect(@admin.blocks.length).must_equal 0
    end

    it "should have all rooms available on 2019-01-01 and 2019-12-31 when initialized" do
      expect(@admin.list_available_rooms(Date.parse("2019-01-01")).length).must_equal @admin.rooms.length
      expect(@admin.list_available_rooms(Date.parse("2019-12-31")).length).must_equal @admin.rooms.length
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

    it "makes the assigned rooms unavailable for the checkin date through night before checkout" do
      expect(res1.rooms.first.is_available?(res1.checkin_date, res1.checkout_date)).must_equal false
      expect(res1.rooms.first.is_available?(res1.checkout_date)).must_equal true
      expect(res2.rooms.last.is_available?(res2.checkin_date, res2.checkout_date)).must_equal false
      expect(res2.rooms.last.is_available?(res2.checkout_date)).must_equal true
    end

    it "updates the assigned rooms' availability to :BOOKED" do
      res1.checkin_date.upto(res1.checkout_date.prev_day) do |date|
        expect(res1.rooms.first.availability[date.to_s][:status]).must_equal :BOOKED
      end
      res2.checkin_date.upto(res1.checkout_date.prev_day) do |date|
        expect(res1.rooms.last.availability[date.to_s][:status]).must_equal :BOOKED
      end
    end

    it "can make a reservation that checks in on the checkout date of another reservation" do
      # all rooms open on 3/6/2019 and 3/7/2019
      expect(@admin.list_available_rooms(Date.parse("2019-03-06")).length).must_equal @admin.rooms.length
      expect(@admin.list_available_rooms(Date.parse("2019-03-07")).length).must_equal @admin.rooms.length
      # book up all rooms from checkin date of 3/1/2019 to checkout date of 3/7/2019
      @admin.rooms.length.times do
        @admin.make_reservation(Date.parse("2019-03-01"), Date.parse("2019-03-07"))
      end
      # confirm that reservation was made correctly by showing all rooms
      # unavailable on 3/6/2019, but all still available 3/7/2019
      expect(@admin.list_available_rooms(Date.parse("2019-03-06")).length).must_equal 0
      expect(@admin.list_available_rooms(Date.parse("2019-03-07")).length).must_equal @admin.rooms.length
      # create overlapping reservations that start on 3/7/2019
      @admin.rooms.length.times do
        @admin.make_reservation(Date.parse("2019-03-07"), Date.parse("2019-03-14"))
      end
      # confirm that overlapping reservations were made and hotel is now completely booked on 3/7/2019 and 3/13/2019
      expect(@admin.list_available_rooms(Date.parse("2019-03-07")).length).must_equal 0
      expect(@admin.list_available_rooms(Date.parse("2019-03-13")).length).must_equal 0
    end

    it "can make a reservation that checks out on the checkin date of another reservation" do
      # all rooms open on 4/1/2019 and 4/7/2019
      expect(@admin.list_available_rooms(Date.parse("2019-04-01")).length).must_equal @admin.rooms.length
      expect(@admin.list_available_rooms(Date.parse("2019-04-07")).length).must_equal @admin.rooms.length
      # book up all rooms from checkin date of 4/1/2019 to checkout date of 4/7/2019
      @admin.rooms.length.times do
        @admin.make_reservation(Date.parse("2019-04-01"), Date.parse("2019-04-07"))
      end
      # confirm that reservation was made correctly by showing all rooms
      # unavailable on 4/6/2019, but all still available 4/7/2019
      expect(@admin.list_available_rooms(Date.parse("2019-04-01")).length).must_equal 0
      expect(@admin.list_available_rooms(Date.parse("2019-04-07")).length).must_equal @admin.rooms.length
      # create overlapping reservations that end on 4/1/2019
      @admin.rooms.length.times do
        @admin.make_reservation(Date.parse("2019-03-28"), Date.parse("2019-04-01"))
      end
      # confirm that overlapping reservations were made and hotel is now completely booked on 3/28/2019 and 4/1/2019
      expect(@admin.list_available_rooms(Date.parse("2019-03-28")).length).must_equal 0
      expect(@admin.list_available_rooms(Date.parse("2019-04-01")).length).must_equal 0
    end

    it "can't make reservations that overlap in any way except checkin/checkout date if all rooms are booked" do
      # book hotel completely from 4/1/2019 through 4/7/2019
      @admin.rooms.length.times do
        @admin.make_reservation(Date.parse("2019-04-01"), Date.parse("2019-04-07"))
      end
      # same dates
      expect{@admin.make_reservation(Date.parse("2019-04-01"), Date.parse("2019-04-07"))}.must_raise Hotel::RoomAvailabilityError
      # overlaps in front
      expect{@admin.make_reservation(Date.parse("2019-03-28"), Date.parse("2019-04-02"))}.must_raise Hotel::RoomAvailabilityError
      # overlaps in back
      expect{@admin.make_reservation(Date.parse("2019-04-05"), Date.parse("2019-04-12"))}.must_raise Hotel::RoomAvailabilityError
      # is completely contained
      expect{@admin.make_reservation(Date.parse("2019-04-03"), Date.parse("2019-04-06"))}.must_raise Hotel::RoomAvailabilityError
      # is completely containing
      expect{@admin.make_reservation(Date.parse("2019-03-21"), Date.parse("2019-04-19"))}.must_raise Hotel::RoomAvailabilityError
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
    it "returns a list of all reservations on a specific date in hash organized by confirmation code" do
      10.times do
        @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-04"))
      end
      expect(@admin.list_reservations(Date.parse("2019-01-01")).length).must_equal 10
      expect(@admin.list_reservations(Date.parse("2019-01-01")).keys.first).must_equal 1
      expect(@admin.list_reservations(Date.parse("2019-01-01")).keys.last).must_equal 10
      expect(@admin.list_reservations(Date.parse("2019-01-01")).values.first).must_be_instance_of Hotel::Reservation
      expect(@admin.list_reservations(Date.parse("2019-01-01")).values.last).must_be_instance_of Hotel::Reservation
    end
  end

  describe "Admin#list_available_rooms" do
    it "returns a list of available rooms for a given date" do
      @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-02"))
      @admin.make_reservation(Date.parse("2019-01-01"), Date.parse("2019-01-04"))
      expect(@admin.list_available_rooms(Date.parse("2019-01-01")).length).must_equal 18
      expect(@admin.list_available_rooms(Date.parse("2019-01-03")).length).must_equal 19
      expect(@admin.list_available_rooms(Date.parse("2019-01-03")).first).must_be_instance_of Hotel::Room
      expect(@admin.list_available_rooms(Date.parse("2019-01-03")).first.is_available? Date.parse("2019-01-03")).must_equal true
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

    it "raises an exception if not enough rooms are available for dates and quantity selected" do
      8.times do
        @admin.make_reservation(@checkin_date, @checkout_date)
      end
      2.times do
        @admin.make_block(@block_name, @checkin_date, @checkout_date, @discount_rate, @room_quantity)
      end
      expect{@admin.make_block(@block_name, @checkin_date, @checkout_date, @discount_rate, @room_quantity)}.must_raise Hotel::RoomAvailabilityError
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

  describe "Admin#find_room" do
    it "raises an error if no room found" do
      expect{@admin.find_room(21)}.must_raise ArgumentError
    end

    it "returns the room with the corresponding room number if found" do
      expect(@admin.find_room(15)).must_be_instance_of Hotel::Room
      expect(@admin.find_room(15).room_num).must_equal 15
    end
  end
end
