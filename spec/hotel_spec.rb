require_relative 'spec_helper'
require 'pry'

describe "Hotel Class: Wave One: Tracking Reservations" do
  describe "hotel class initialize" do
    before do
      @hotel = Hotel.new(20)
    end
    it "creates 20 hotel rooms" do
      expect(@hotel.rooms.length).must_equal 20
    end
    it "each hotel room is an instance of a room" do
      expect(@hotel.rooms[0]).must_be_instance_of Room
    end
  end

  describe "list_rooms" do
    before do
      @hotel = Hotel.new(20)
    end
    it "list_rooms lists all of the rooms" do
      expect(@hotel.list_rooms.length).must_equal 20
    end
  end


  describe "reserve_room" do
    before do
      @hotel = Hotel.new(20)
      @hotel.reserve_room('2018-02-03', '2018-02-05', 1)
    end

    it "adds reservation to reservation list" do
      expect(@hotel.reservations.length).must_equal 1
    end

    it "creates and instance of Reservation" do
      expect(@hotel.reservations[0]).must_be_instance_of Reservation
    end

    it "has a reservation cost" do
      expect(@hotel.reservations[0].cost).must_be_kind_of Integer
    end

    it "adds a reservation to the first available room" do
      expect(@hotel.rooms[0].reservations[0]).must_equal @hotel.reservations[0]
    end

    it "the reservation and room are connected" do
      expect(@hotel.reservations[0].rooms[0].room_number).must_be_same_as @hotel.rooms[0].room_number
    end

    it "can book multiple rooms" do
      @hotel.reserve_room('2018-02-03', '2018-02-09', 2)
      expect(@hotel.reservations[1].rooms.length).must_equal 2
    end

    it "raises an error for unavailable dates" do
      @hotel.reserve_room('2018-03-01', '2018-03-15', 20)

      #same dates
      expect{@hotel.reserve_room('2018-03-01', '2018-03-15', 1)}.must_raise ArgumentError
      #overlaps in the front
      expect{@hotel.reserve_room('2018-02-28', '2018-03-15', 1)}.must_raise ArgumentError
      #overlaps in the back
      expect{@hotel.reserve_room('2018-03-01', '2018-03-18', 1)}.must_raise ArgumentError
      #completely contained
      expect{@hotel.reserve_room('2018-03-05', '2018-03-13', 1)}.must_raise ArgumentError
      #completely containing
      expect{@hotel.reserve_room('2018-02-28', '2018-03-16', 1)}.must_raise ArgumentError
    end

    it "does not raise an error for date ranges that are not overlapping " do
      @hotel.reserve_room('2018-04-01', '2018-04-15', 20)

      #completely before
      expect(@hotel.reserve_room('2018-03-01', '2018-03-15', 1))
      #completely after
      expect(@hotel.reserve_room('2018-04-16', '2018-04-18', 1))
      #ends on the checkin date
      expect(@hotel.reserve_room('2018-03-20', '2018-04-01', 1))
      #starts on the checkout date
      expect(@hotel.reserve_room('2018-04-15', '2018-04-18', 1))
    end

    it "reservation can start on the same day that another reservation for the same room ends" do
      @hotel.reserve_room('2018-03-01', '2018-03-15', 20)
      expect{@hotel.reserve_room('2018-03-15', '2018-03-20', 1)}.must_be_silent
    end

  end

  describe "list_reservations" do
    before do
      @hotel = Hotel.new(20)
      @hotel.reserve_room('2018-02-03', '2018-02-05', 1)
      @hotel.reserve_room('2018-02-03', '2018-02-09', 1)
    end

    it "lists the reservations for a specific date" do
      expect(@hotel.list_reservations('2018-02-03').length).must_equal 2
    end

    it "creates an array of reservations" do
      expect(@hotel.list_reservations('2018-02-03')).must_be_kind_of Array
    end

    it "the array has reservation instances" do
      expect(@hotel.list_reservations('2018-02-03')[0]).must_be_kind_of Reservation
    end

  end

  describe "reservation_cost" do
    before do
      @hotel = Hotel.new(20)
      @hotel.reserve_room('2018-02-03', '2018-02-05', 1)

      @reservation_code = @hotel.reservations[0].reservation_id
    end

    it "returns the total cost for a given reservation" do
      expect(@hotel.reservation_cost(@reservation_code)).must_equal 400
    end

    it "raises an error for invalid id" do
      expect{@hotel.reservation_cost(12345)}.must_raise ArgumentError
    end
  end
end

describe "Hotel Class: Wave Two: Room Availability" do

  describe "list_not_reserved_rooms" do
    before do
      @hotel = Hotel.new(20)
      @hotel.reserve_room('2018-02-03', '2018-02-05', 1)
    end

    it "lists all rooms not reserved" do
      expect(@hotel.list_available_rooms('2018-01-03', '2018-01-05').length).must_equal 20
      expect(@hotel.list_available_rooms('2018-02-03','2018-02-05').length).must_equal 19
    end

    it "warns user that all rooms that date are reserved" do
      @hotel.reserve_room('2018-04-03', '2018-04-05', 20)

      expect(@hotel.list_available_rooms('2018-04-03', '2018-04-05')).must_equal "All rooms are reserved from 2018-04-03 to 2018-04-05."
    end
  end

end


describe "Hotel Class: Wave Three: Blocks of Rooms" do

  describe "create_room_block" do
    before do
      @hotel = Hotel.new(20)
      @hotel.create_room_block('2018-01-03', '2018-01-05', 5, 150)
      @block_id = @hotel.room_blocks[0].block_id

    end

    it "can create a block of rooms" do
      expect(@hotel.room_blocks[0]).must_be_instance_of BlockRooms
    end

    it "can check whether a given block has any rooms available" do
      expect(@hotel.list_available_block_rooms(@block_id).length).must_equal 5
    end

    it "can reserve a room from within a block of rooms" do
      @hotel.reserve_block_room(@block_id, 1)

      expect(@hotel.list_available_block_rooms(@block_id).length).must_equal 4
      expect(@hotel.room_blocks[0].rooms_reserved.length).must_equal 1

    end

    it "a block can contain a maximum of 5 rooms" do

      expect{@hotel.create_room_block('2018-09-05', '2018-09-10', 7, 150)}.must_raise ArgumentError
    end

    it "when a room is reserved from a block, the reservation dates will match the date range of the block" do
      @hotel.reserve_block_room(@block_id, 1)

      expect(@hotel.reservations[0].start_date).must_equal @hotel.room_blocks[0].start_date
      expect(@hotel.reservations[0].end_date).must_equal @hotel.room_blocks[0].end_date

    end

    it "if a room is set aside in a block, it is not available for reservation" do
      @hotel.create_room_block('2018-05-03', '2018-05-08', 5, 150)
      @hotel.create_room_block('2018-05-03', '2018-05-08', 5, 150)
      @hotel.create_room_block('2018-05-03', '2018-05-08', 5, 150)
      @hotel.create_room_block('2018-05-03', '2018-05-08', 5, 150)

      expect{@hotel.reserve_room('2018-05-03', '2018-05-10', 1)}.must_raise ArgumentError
    end

    it "if a room is set aside in a block it can't be included in another block" do
      @hotel.create_room_block('2018-05-03', '2018-05-08', 5, 150)
      @hotel.create_room_block('2018-05-03', '2018-05-08', 5, 150)
      @hotel.create_room_block('2018-05-03', '2018-05-08', 5, 150)
      @hotel.create_room_block('2018-05-03', '2018-05-08', 5, 150)

      expect{@hotel.create_room_block('2018-05-05', '2018-05-08', 7, 150)}.must_raise ArgumentError
    end

    it "will give the block rooms a discounted rate" do
      @hotel.reserve_block_room(@block_id, 1)
      @hotel.reserve_room('2018-01-03', '2018-01-05', 1)

      expect(@hotel.reservations[0].cost).must_equal 300
      expect(@hotel.reservations[1].cost).must_equal 400
    end

    it "raises error for invalid block id" do

      expect{@hotel.find_block_booking("hello")}.must_raise ArgumentError
    end
  end

end
