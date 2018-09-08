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

  let (:booked_reservation) {
    sample_booking.make_reservation(sample_checkin, sample_checkout)
  }

  describe '#initialize' do

    it 'must create an array of 20 room hashes when created' do
      expect(sample_booking.rooms).must_be_kind_of  Array
      expect(sample_booking.rooms.length).must_equal 20
      expect(sample_booking.rooms[0]).must_be_kind_of Integer
    end

  end


  describe '#find_available_room' do

    it 'must return a valid room number' do
      expect(sample_booking.find_available_room(sample_checkin, sample_checkout)).must_be_kind_of Integer
    end

    it 'must equal a number greater than 0' do
      expect(sample_booking.find_available_room(sample_checkin, sample_checkout)).must_be :>, 0
    end

    it 'must equal a number less than 21' do
      expect(sample_booking.find_available_room(sample_checkin, sample_checkout)).must_be :<, 21
    end

  end

  # Wave 2 checks


  # - Overlaps in the front
  # - Overlaps in the back
  # - Completely contained
  # - Completely containing
  #
  # Two date ranges are *not* overlapping if range A compared to range B:
  # - Completely before
  # - Completely after
  # - Ends on the checkin date
  # - Starts on the checkout date (edited)
  #

  describe 'booking_conflicts' do
    # Two date ranges *do* overlap if range A compared to range B:
    # - Same dates
    it 'must raise standard error if two reservations made for the same date' do
      reservation_conflict = sample_booking.make_reservation(sample_checkin, sample_checkout)

      expect{reservation_conflict.find_available_room(sample_checkin, sample_chekout)}.must_raise StandardError
    end
  end


  describe '#make_reservation' do

    it 'must return a reservation object' do
      expect(sample_booking.make_reservation(Date.new(2018, 3, 5), Date.new(2018, 3, 8))).must_be_kind_of Reservation
    end
  end

end
