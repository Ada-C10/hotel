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
end
