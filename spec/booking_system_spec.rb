require_relative 'spec_helper'
require 'pry'

describe 'BookingSystem class' do
  before do
    @booking = BookingSystem.new
  end

  describe 'Initializer' do
    it 'is an instance of BookingSystem' do
      expect(@booking).must_be_kind_of BookingSystem
    end

    it 'loads an array of rooms' do
      expect(@booking.rooms).must_be_kind_of Array
    end

  end

  describe 'load_rooms' do
    it 'is an instance of Room' do
      expect(@booking.rooms.first).must_be_kind_of Room
    end
  end

  describe 'list_all_rooms' do
    it 'returns a list of all the rooms in the hotel' do
      expect(@booking.list_all_rooms).must_be_kind_of Array
    end
  end

  describe 'reserve_room' do
    it 'returns a new reservation of instance Reservation' do
      expect(@booking.reserve_room("Feb 1st 2019", "Feb 5th 2019")).must_be_kind_of Reservation
    end

    it "shovels dates from new reservation to a room's dates_booked array" do
      check_in = "Feb 1st 2019"
      check_out = "Feb 5th 2019"
      my_reservation = @booking.reserve_room(check_in, check_out)
      all_rooms = @booking.list_all_rooms
      expect(all_rooms[0].dates_booked.count).must_equal 4
      expect(all_rooms[1].dates_booked.count).must_equal 0
    end
  end


end
