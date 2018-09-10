require_relative 'spec_helper.rb'
require 'pry'
require 'minitest/skip_dsl'


describe 'BookingManager' do

  let (:sample_booking) {
    BookingManager.new
  }
  #
  let (:fully_booked) {
    new_booking = BookingManager.new
    20.times do
      new_booking.make_reservation(Date.new(2018, 1, 1), Date.new(2018, 1, 7))
    end
    new_booking
  }

  describe '#initialize' do

    it 'must create an array of 20 room integers when created' do
      expect(sample_booking.rooms).must_be_kind_of  Array
      expect(sample_booking.rooms.length).must_equal 20
      expect(sample_booking.rooms[0]).must_be_kind_of Integer
    end

  end

end


describe '#find_available_rooms' do
  # fully_booked: hotel filled from 2018, 1, 1 til 2018 1, 7
  # - Same dates
  it 'must raise standard error if two reservations made for the same date' do
    expect{fully_booked.make_reservation(Date.new(2018, 1, 1), Date.new(2018, 1, 7))}.must_raise StandardError
  end
  # - Overlaps in the front: overlap from 2018, 1 ,1 til 2018, 1, 5
  it 'raises an error if room bookings overlap in the front' do
    expect{fully_booked.make_reservation(Date.new(2017, 12, 25), Date.new(2018, 1, 5))}.must_raise StandardError
  end

  # - Overlaps in the back: overlap from 2018, 1, 3 to 2018, 1, 5
  it 'raises an error if room bookings overlap in the back' do
    expect{fully_booked.make_reservation(Date.new(2017, 1, 3), Date.new(2018, 1, 9))}.must_raise StandardError
  end

  # - Completely contained
  it 'raises an error if room bookings completely contained in fully booked hotel' do
    expect{fully_booked.make_reservation(Date.new(2017, 1, 2), Date.new(2018, 1, 5))}.must_raise StandardError
  end

  # Completely containing
  it 'raises an error if room bookings completely containing block where hotel is maxed out' do
    expect{fully_booked.make_reservation(Date.new(2017, 12, 25), Date.new(2018, 1, 10))}.must_raise StandardError
  end

  
end
