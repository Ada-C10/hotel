require 'simplecov'
SimpleCov.start
require 'pry'

require_relative 'spec_helper'

describe 'ReservationTracker class' do
  describe 'initialize' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'has an array of all rooms in the hotel' do
      expect(@reservation_tracker.rooms).must_be_kind_of Array
    end

    it 'has 20 rooms in the hotel' do
      expect(@reservation_tracker.rooms.length).must_equal 20
    end

    it 'has an array of all the reservations in the hotel' do
      expect(@reservation_tracker.reservations).must_be_kind_of Array
    end

    it 'has an array of all the unreserved rooms in the hotel' do
      expect(@reservation_tracker.unreserved_rooms).must_be_kind_of Array
    end

    # it 'should be able to access the list of rooms' do
    #   binding.pry
    #   expect(@reservation_tracker.rooms[0]).must_equal 1
    #   expect(@reservation_tracker.rooms[20]).must_equal 20
    # end
  end

  describe 'create reservation method' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'reserves a room in a given date range' do
      # check_in_date = Date.today
      # check_out_date = Date.today + 5
      date = Date.today
      room = Room.new(15)
      expect(@reservation_tracker.create_reservation(date, date + 5, room)).must_be_kind_of Array
    end

    it "should be able to add a reservation" do
      reservation = Reservation.new(Date.new(2018,9,5), Date.new(2018,9,10), 15)
      @reservation_tracker.reservations << reservation
      @reservation_tracker.reservations.must_equal [reservation]
    end

    # it "creates a reservation with a specific date range" do
    #   check_in_date = Date.new(2018,9,5)
    #   check_out_date = Date.new(2018,9,10)
    #   reservation = Reservation.new(check_in_date, check_out_date, 15)
    #   @reservation_tracker.reservations[check_in_date].must_equal Date.new(2018,9,5)
    #   @reservation_tracker.reservations[check_out_date].must_equal Date.new(2018,9,10)
    # end
  end

  # don't think I need this since I check this in the reserve_room method.
  # describe 'is a room available method' do
  #   before do
  #     @reservation_tracker = ReservationTracker.new
  #     #.create_reservation(check_in_date, check_out_date, room)
  #
  #     # @date = Date.today
  #     # @room = Room.new(15)
  #   end
  #
  #   it 'can check its availability on a specific date' do
  #
  #     check_in_date = Date.new(2018, 9, 6)
  #     check_out_date = Date.new(2018, 9, 10)
  #     room = 15
  #     reservation = Reservation.new(check_in_date, check_out_date, room)
  #
  #     expect(@reservation_tracker.is_a_room_available?(Date.new(2018, 9, 7))).must_equal false
  #     expect(@reservation_tracker.is_a_room_available?(Date.new(2018, 9, 11))).must_equal true
  #   end
  #
  #   it 'has a room to be available on the last day of a reservation' do
  #     check_in_date = Date.new(2018, 9, 6)
  #     check_out_date = Date.new(2018, 9, 10)
  #     # room = 15
  #     # reservation = Reservation.new(check_in_date, check_out_date, room)
  #     expect(@reservation_tracker.is_a_room_available?(Date.new(2018, 9, 10))).must_equal true
  #   end
  # end

  describe 'list of reservations method' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'shows the list of reservations for a specific date' do
      date = Date.new(2018, 9, 7)

      expect(@reservation_tracker.list_of_reservations(date)).must_be_kind_of Array
    end
  end

  describe 'cost for given reservation method' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'calculates the cost of a specific reservation' do
      check_in_date = Date.new(2018, 9, 6)
      check_out_date = Date.new(2018, 9, 10)
      room = 15
      reservation = Reservation.new(check_in_date, check_out_date, room)

      expect(@reservation_tracker.cost_for_given_reservation(reservation)).must_be_kind_of Integer
      expect(@reservation_tracker.cost_for_given_reservation(reservation)).must_equal 800
    end
  end

  describe 'reserve_room method' do
    before do
      @reservation_tracker = ReservationTracker.new
      @date = Date.today
      20.times do |i|
        @reservation_tracker.reserve_room(@date, @date + 5)
      end
    end

    it "Raises ArgumentError if there are no available rooms" do

      expect { @reservation_tracker.reserve_room(@date, @date + 5) }.must_raise ArgumentError
   end
  end

  describe 'rooms not reserved method' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'returns an array of rooms that are not reserved for a given date range' do
      check_in_date = Date.new(2018, 9, 7)
      check_out_date = Date.new(2018, 9, 10)
      expect(@reservation_tracker.rooms_not_reserved(check_in_date, check_out_date)).must_be_kind_of Array
    end

    it 'returns a list of rooms not reserved' do
       date = Date.today
       @reservation_tracker.create_rooms
       @reservation_tracker.create_reservation(date, date + 5, 5)
       @reservation_tracker.create_reservation(date, date + 5, 10)
       @reservation_tracker.create_reservation(date + 10, date + 25, 15)
       @reservation_tracker.rooms_not_reserved(date, date + 5).must_equal [1, 2, 3, 4, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end
  end
end
