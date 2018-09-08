require_relative 'spec_helper.rb'
require 'pry'

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
  }
  # let (:booked_reservation) {
  #   sample_booking.make_reservation(sample_checkin, sample_checkout)
  # }
  #

  describe '#initialize' do

    it 'must create an array of 20 room hashes when created' do
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

  # Wave 2 checks

  # - Completely contained
  # - Completely containing
  #
  # Two date ranges are *not* overlapping if range A compared to range B:
  # - Completely before
  # - Completely after
  # - Ends on the checkin date
  # - Starts on the checkout date (edited)
  #
  describe '#find_available_rooms' do
    # Two date ranges *do* overlap if range A compared to range B:
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

  end



end
