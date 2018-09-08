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
  end

  describe 'reserve a room method' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'reserves a room in a given date range' do
      check_in_date = Date.new(2018, 9, 7)
      check_out_date = Date.new(2018, 9, 10)
      expect(@reservation_tracker.reserve_a_room(check_in_date, check_out_date)).must_be_kind_of Reservation

    end
  end

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

  describe 'rooms that are not reserved method' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'returns a list of rooms that are not reserved for a given date range' do
      check_in_date = Date.new(2018, 9, 7)
      check_out_date = Date.new(2018, 9, 10)
      expect(@reservation_tracker.rooms_not_reserved(check_in_date, check_out_date)).must_be_kind_of Array
    end
  end
end
