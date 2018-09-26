# Jacquelyn Cheng - Nodes

# Tests for bookingsystem.rb

require_relative 'spec_helper.rb'

describe "BookingSystem" do
  before do
    @bookingsystem = Hotel::BookingSystem.new
  end

  describe "BookingSystem#initialize" do
    it "instantiates a BookingSystem" do
      expect(@bookingsystem).must_be_instance_of Hotel::BookingSystem
    end

    it "has a list of 20 Room objects" do
      expect(@bookingsystem.rooms.length).must_equal 20
      expect(@bookingsystem.rooms.first).must_be_instance_of Hotel::Room
      expect(@bookingsystem.rooms.last).must_be_instance_of Hotel::Room
    end

    it "has an empty collection of reservations when initialized" do
      expect(@bookingsystem.reservations.length).must_equal 0
    end

    it "has an empty collection of blocks when initialized" do
      expect(@bookingsystem.blocks.length).must_equal 0
    end
  end

  describe "BookingSystem#reserve_room" do
    before do
      @checkin = Date.parse("2019-01-01")
      @checkout = Date.parse("2019-01-04")
      @block_name = "Jackie's Event"
      @block_checkin = Date.parse("2019-02-01")
      @block_checkout = Date.parse("2019-02-05")
    end

    let (:res1) {
      @bookingsystem.reserve_room(@checkin, @checkout)
    }

    let (:res2) {
      @bookingsystem.reserve_room(@checkin, Date.parse("2019-01-02"))
    }

    let (:block) {
      @bookingsystem.block_rooms(@block_name, @block_checkin, @block_checkout)
    }

    it "returns a Reservation with correct reservation dates" do
      expect(res1).must_be_instance_of Hotel::Reservation
      expect(res1.checkin).must_be_instance_of Date
      expect(res1.checkin.to_s).must_equal "2019-01-01"
      expect(res1.checkout).must_be_instance_of Date
      expect(res1.checkout.to_s).must_equal "2019-01-04"
    end

    it "assigns a room to the Reservation" do
      expect(res1.room).must_be_instance_of Hotel::Room
      expect(res2.room).must_be_instance_of Hotel::Room
    end

    it "makes the assigned rooms unavailable for the checkin date through night before checkout" do
      expect(@bookingsystem.available_rooms(res1.checkin, res1.checkout).include? res1.room).must_equal false
      expect(@bookingsystem.available_rooms(res1.checkout, res1.checkout.next_day).include? res1.room).must_equal true
    end

    it "can make a reservation that checks in on the checkout date of another reservation" do
      # all rooms open on 3/6/2019 and 3/7/2019
      expect(@bookingsystem.available_rooms(Date.parse("2019-03-06")).length).must_equal @bookingsystem.rooms.length
      expect(@bookingsystem.available_rooms(Date.parse("2019-03-07")).length).must_equal @bookingsystem.rooms.length
      # book up all rooms from checkin date of 3/1/2019 to checkout date of 3/7/2019
      @bookingsystem.rooms.length.times do
        @bookingsystem.reserve_room(Date.parse("2019-03-01"), Date.parse("2019-03-07"))
      end
      # confirm that reservation was made correctly by showing all rooms
      # unavailable on 3/6/2019, but all still available 3/7/2019
      expect{@bookingsystem.available_rooms(Date.parse("2019-03-06"))}.must_raise Hotel::RoomAvailabilityError
      expect(@bookingsystem.available_rooms(Date.parse("2019-03-07")).length).must_equal @bookingsystem.rooms.length
      # create overlapping reservations that start on 3/7/2019
      @bookingsystem.rooms.length.times do
        @bookingsystem.reserve_room(Date.parse("2019-03-07"), Date.parse("2019-03-14"))
      end
      # confirm that overlapping reservations were made and hotel is now completely booked on 3/7/2019 and 3/13/2019
      expect{@bookingsystem.available_rooms(Date.parse("2019-03-07"))}.must_raise Hotel::RoomAvailabilityError
      expect{@bookingsystem.available_rooms(Date.parse("2019-03-13"))}.must_raise Hotel::RoomAvailabilityError
    end

    it "can make a reservation that checks out on the checkin date of another reservation" do
      # all rooms open on 4/1/2019 and 4/7/2019
      expect(@bookingsystem.available_rooms(Date.parse("2019-04-01")).length).must_equal @bookingsystem.rooms.length
      expect(@bookingsystem.available_rooms(Date.parse("2019-04-07")).length).must_equal @bookingsystem.rooms.length
      # book up all rooms from checkin date of 4/1/2019 to checkout date of 4/7/2019
      @bookingsystem.rooms.length.times do
        @bookingsystem.reserve_room(Date.parse("2019-04-01"), Date.parse("2019-04-07"))
      end
      # confirm that reservation was made correctly by showing all rooms
      # unavailable on 4/6/2019, but all still available 4/7/2019
      expect{@bookingsystem.available_rooms(Date.parse("2019-04-01"))}.must_raise Hotel::RoomAvailabilityError
      expect(@bookingsystem.available_rooms(Date.parse("2019-04-07")).length).must_equal @bookingsystem.rooms.length
      # create overlapping reservations that end on 4/1/2019
      @bookingsystem.rooms.length.times do
        @bookingsystem.reserve_room(Date.parse("2019-03-28"), Date.parse("2019-04-01"))
      end
      # confirm that overlapping reservations were made and hotel is now completely booked on 3/28/2019 and 4/1/2019
      expect{@bookingsystem.available_rooms(Date.parse("2019-03-28"))}.must_raise Hotel::RoomAvailabilityError
      expect{@bookingsystem.available_rooms(Date.parse("2019-04-01"))}.must_raise Hotel::RoomAvailabilityError
    end

    it "can't make reservations that overlap in any way except checkin/checkout date if all rooms are booked" do
      # book hotel completely from 4/1/2019 through 4/7/2019
      @bookingsystem.rooms.length.times do
        @bookingsystem.reserve_room(Date.parse("2019-04-01"), Date.parse("2019-04-07"))
      end
      # same dates
      expect{@bookingsystem.reserve_room(Date.parse("2019-04-01"), Date.parse("2019-04-07"))}.must_raise Hotel::RoomAvailabilityError
      # overlaps in front
      expect{@bookingsystem.reserve_room(Date.parse("2019-03-28"), Date.parse("2019-04-02"))}.must_raise Hotel::RoomAvailabilityError
      # overlaps in back
      expect{@bookingsystem.reserve_room(Date.parse("2019-04-05"), Date.parse("2019-04-12"))}.must_raise Hotel::RoomAvailabilityError
      # is completely contained
      expect{@bookingsystem.reserve_room(Date.parse("2019-04-03"), Date.parse("2019-04-06"))}.must_raise Hotel::RoomAvailabilityError
      # is completely containing
      expect{@bookingsystem.reserve_room(Date.parse("2019-03-21"), Date.parse("2019-04-19"))}.must_raise Hotel::RoomAvailabilityError
    end

    it "raises an error if provided end date before start date" do
      expect{
        @bookingsystem.reserve_room(@checkout, @checkin)
      }.must_raise Hotel::BookingDates::InvalidBookingDatesError
    end

    it "raises an error if no rooms are available for dates selected" do
      expect{
        (@bookingsystem.rooms.length + 1).times do
          @bookingsystem.reserve_room(@checkin, @checkout)
        end
      }.must_raise Hotel::RoomAvailabilityError
    end

    it "can reserve a room from within a block of rooms at a discounted rate" do
      expect(block.num_rooms_available).must_equal 5
      expect(block.num_rooms_booked).must_equal 0
      new_res = @bookingsystem.reserve_room(@block_checkin, @block_checkout, block: block)
      expect(block.num_rooms_available).must_equal 4
      expect(block.num_rooms_booked).must_equal 1
      expect(new_res.block).must_equal block
      expect(new_res.rate).must_equal block.discount_rate
    end

    it "raises an error if no availability in block" do
      expect{ (block.num_rooms_available + 1).times do
        @bookingsystem.reserve_room(@block_checkin, @block_checkout, block: block)
      end }.must_raise Hotel::RoomAvailabilityError
    end
  end

  describe "BookingSystem#list_reservations" do
    it "returns a list of all reservations on a specific date" do
      @bookingsystem2 = Hotel::BookingSystem.new

      10.times do
        @bookingsystem2.reserve_room(Date.parse("2019-01-01"), Date.parse("2019-01-04"))
      end

      expect(@bookingsystem2.list_reservations(Date.parse("2019-01-01")).length).must_equal 10
      expect(@bookingsystem2.list_reservations(Date.parse("2019-01-01")).first).must_be_instance_of Hotel::Reservation
      expect(@bookingsystem2.list_reservations(Date.parse("2019-01-01")).last).must_be_instance_of Hotel::Reservation
    end
  end

  describe "BookingSystem#available_rooms" do
    it "returns a list of available rooms for a given date" do
      res1 = @bookingsystem.reserve_room(Date.parse("2019-01-01"), Date.parse("2019-01-02"))
      res2 = @bookingsystem.reserve_room(Date.parse("2019-01-01"), Date.parse("2019-01-04"))
      expect(@bookingsystem.available_rooms(Date.parse("2019-01-01")).length).must_equal 18
      expect(@bookingsystem.available_rooms(Date.parse("2019-01-03")).length).must_equal 19
      expect(@bookingsystem.available_rooms(Date.parse("2019-01-03")).first).must_be_instance_of Hotel::Room
      expect(@bookingsystem.available_rooms(Date.parse("2019-01-01")).include? res1.room).must_equal false
    end
  end

  describe "BookingSystem#block_rooms" do
    before do
      @block_name = "Jackie's Event"
      @checkin = Date.parse("2019-02-01")
      @checkout = Date.parse("2019-02-05")
      @room_quantity = 4
    end

    let (:block) {
      @bookingsystem.block_rooms(@block_name, @checkin, @checkout, room_quantity: @room_quantity)
    }

    it "returns a Block with correct reservation dates" do
      expect(block).must_be_instance_of Hotel::Block
      expect(block.checkin).must_be_instance_of Date
      expect(block.checkin.to_s).must_equal @checkin.to_s
      expect(block.checkout).must_be_instance_of Date
      expect(block.checkout.to_s).must_equal @checkout.to_s
    end

    it "assigns a collection of rooms to the Block" do
      expect(block.rooms).must_be_kind_of Enumerable
      expect(block.rooms.first).must_be_instance_of Hotel::Room
      expect(block.rooms.last).must_be_instance_of Hotel::Room
      expect(block.rooms.length).must_equal @room_quantity
    end

    it "makes the assigned rooms unavailable for appropriate dates" do
      block
      expect(@bookingsystem.available_rooms(@checkin).include? block.rooms.first).must_equal false
      expect(@bookingsystem.available_rooms(@checkout.prev_day).include? block.rooms.first).must_equal false
      expect(@bookingsystem.available_rooms(@checkout).include? block.rooms.first).must_equal true
    end

    it "raises an error if provided end date before start date" do
      expect{
        @bookingsystem.block_rooms(@block_name, @checkout, @checkin, room_quantity: @room_quantity)
      }.must_raise Hotel::BookingDates::InvalidBookingDatesError
    end

    it "raises an error if not enough rooms are available for dates selected" do
      expect{
        7.times do
          @bookingsystem.block_rooms(@block_name, @checkin, @checkout, room_quantity: 3)
        end
      }.must_raise Hotel::RoomAvailabilityError
    end

    it "raises an error if there's a request for more than 5 rooms or less than 1 room to be blocked" do
      expect{@bookingsystem.block_rooms(@block_name, @checkin, @checkout, room_quantity: 6)}.must_raise Hotel::Block::InvalidBlockError
      expect{@bookingsystem.block_rooms(@block_name, @checkin, @checkout, room_quantity: 0)}.must_raise Hotel::Block::InvalidBlockError
    end
  end

  # describe "BookingSystem#change_rate" do
  #   it "changes the nightly rate for a specific room on a specific date" do
  #     expect(@bookingsystem.find_room(10).nightly_rate(Date.parse("2019-01-01"))).must_equal 200.00
  #     @bookingsystem.change_rate(10, Date.parse("2019-01-01"), 180.00)
  #     expect(@bookingsystem.find_room(10).nightly_rate(Date.parse("2019-01-01"))).must_equal 180.00
  #   end
  #
  #   it "leaves the nightly rate for other nights and other rooms unchanged" do
  #     expect(@bookingsystem.find_room(10).nightly_rate(Date.parse("2019-01-01"))).must_equal 200.00
  #     @bookingsystem.change_rate(10, Date.parse("2019-01-01"), 180.00)
  #     expect(@bookingsystem.find_room(10).nightly_rate(Date.parse("2019-01-02"))).must_equal 200.00
  #     expect(@bookingsystem.find_room(9).nightly_rate(Date.parse("2019-01-01"))).must_equal 200.00
  #   end
  # end
end
