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

  describe 'Reserve a room for a given date range' do
    it 'reserves a room' do
    end
  end
end
