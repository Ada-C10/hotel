require_relative 'spec_helper'
require 'pry'

describe "ReservationTracker class" do

  before do
    @reservations = ReservationTracker.new

    @reservations.new_reservation(begin_date: '9-10-2018', end_date: '10-10-2018')
    @reservations.new_reservation(begin_date: '9-5-2018', end_date: '9-16-2018')
    @reservations.new_reservation(begin_date: '9-15-2018', end_date: '9-18-2018')
  end


  describe "it can reserve a room for a given date range" do

    before do
        @reservation = @reservations.new_reservation(begin_date: '9-15-2018', end_date: '9-17-2018')
    end

    it "must create a new reservation instance" do
        expect(@reservation).must_be_kind_of Reservation
    end

    it "can find an available_room for the reservation" do
        expect (@reservation.room_num).must_equal 4
    end

    it "raises an ArgumentError if a request is made for an unavailable room" do
      expect { 20.times do
          @reservations.new_reservation(begin_date: '9-16-2018', end_date: '9-17-2018')
        end }.must_raise ArgumentError
    end

    it "can get the total cost for a given reservation" do
      reservation = @reservations.new_reservation(begin_date: '9-1-2018', end_date: '9-5-2018')

      expect (reservation.cost).must_equal 800
    end

    it "A reservation is allowed start on the same day that another reservation for the same room ends" do
      reservation = @reservations.new_reservation(begin_date: '9-18-2018', end_date: '9-20-2018')

      expect (reservation.room_num).must_equal 2
    end
  end



  describe "Room block reservations" do
    before do
      @date_range = {begin_date: '9-10-2018', end_date: '9-15-2018'}
      @room_block = @reservations.reserve_block(@date_range, 5, 150)
    end

    it "reserves a block of rooms" do
      expect (@room_block).must_be_kind_of Reservation
      expect (@room_block.rate).must_equal 150
    end

    it "adds block of rooms to occupied_rooms" do
      expect (@reservations.occupied_rooms(@date_range)).must_equal [1, 2, 3, 4, 5, 6, 7]
    end

    it "prevents non-block reservation of block rooms" do
      @rooms = Room.new
      date_range = Dates::date_range_format(@date_range)
      occupied_rooms = @reservations.occupied_rooms(date_range)
      available_rooms = @rooms.find_all_open_rooms(occupied_rooms)
      expect (available_rooms.include?(4)).must_equal false
    end
  end



  describe "lists of reservations" do
    it "creates a list of all reservations" do
      expect (@reservations.all_reservations).must_be_kind_of Array
      expect (@reservations.all_reservations.length).must_equal 3
    end

    it "can access the list of reservations for a specific date" do
      current_reservations = @reservations.reservation_list_by_date('9-15-2018')
      expect (current_reservations.length).must_equal 3
    end
  end



  describe "list of open rooms" do
    it "can report a list of rooms that are not reserved for a given date range" do
      open_rooms = @reservations.rooms.find_all_open_rooms(@reservations.occupied_rooms(begin_date: '9-18-2018', end_date: '9-20-2018'))
      expect (open_rooms).must_equal [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end
  end
end
