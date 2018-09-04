require_relative 'spec_helper'
require 'pry'

describe 'BookingSystem class' do
  describe 'Initializer' do
    it 'is an instance of BookingSystem' do
      booking = BookingSystem.new

      expect(booking).must_be_kind_of BookingSystem
    end
  end

  describe 'Access the list of all rooms' do
    it 'returns a list of all the rooms in the hotel' do
      booking = BookingSystem.new
      expect(booking.list_all_rooms).must_be_kind_of Array
    end
  end
end
