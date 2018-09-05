require_relative 'spec_helper'
require 'pry'


# # As an administrator, I can access the list of reservations for a specific date

#
# # As an administrator, I can get the total cost for a given reservation
# # hotel.reservations.find_cost(reservation_id)

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
      expect(@hotel.rooms[0].reservations.length).must_equal 1
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
      expect{@hotel.reserve_room('2018-03-01', '2018-03-14', 1)}.must_raise ArgumentError

      @hotel.reserve_room('2018-01-01', '2018-01-15', 1)
      expect{@hotel.reserve_room('2018-01-01', '2018-01-15', 20)}.must_raise ArgumentError
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
