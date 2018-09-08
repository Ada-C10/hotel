require_relative 'spec_helper.rb'
require 'pry'
require 'minitest/skip_dsl'


describe 'BookingManager' do

  let (:sample_booking) {
    BookingManager.new
  }

  let (:sample_checkin) {
    Date.new(2001,3,1)
  }

  let (:sample_checkout) {
    Date.new(2001,3,5)
  }

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

  describe '#make_reservation' do

    it 'must return a reservation object' do
      expect(sample_booking.make_reservation(Date.new(2018, 1, 5), Date.new(2018, 3, 8))).must_be_kind_of Reservation
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
      expect{fully_booked.make_reservation(Date.new(2017, 12, 25), Date.new(2018, 1, 5))}
    end

    # - Overlaps in the back: overlap from 2018, 1, 3 to 2018, 1, 5
    it 'raises an error if room bookings overlap in the back' do
      expect{fully_booked.make_reservation(Date.new(2017, 1, 3), Date.new(2018, 1, 9))}
    end

    # - Completely contained
    it 'raises an error if room bookings completely contained in fully booked hotel' do
      expect{fully_booked.make_reservation(Date.new(2017, 1, 2), Date.new(2018, 1, 5))}
    end

    # Completely containing
    it 'raises an error if room bookings completely containing block where hotel is maxed out' do
      expect{fully_booked.make_reservation(Date.new(2017, 12, 25), Date.new(2018, 1, 10))}
    end

    # - Completely before
    it 'Successfully books reservations if reservations made completely before maxed out rooms' do

      full_house = BookingManager.new
      20.times do
        full_house.make_reservation(Date.new(2018, 1, 1), Date.new(2018, 1, 7))
      end

    added_reservation = full_house.make_reservation(Date.new(1980, 4, 10), Date.new(1980, 4, 15))

      #reservation is valid, returns 5 nights of reservations
      expect(added_reservation.reservation_dates.length).must_equal 5

    end

  # - Completely after
  # - Ends on the checkin date
  # - Starts on the checkout date (edited)
end
end
