require 'simplecov'
SimpleCov.start

require_relative 'spec_helper'

describe 'Reservation' do
  let (:check_in_date) { Date.new(2018, 9, 5) }
  let (:check_out_date) { Date.new(2018, 9, 8) }
  let (:room) { Room.new(15) }
  # let (:a_reservation) { Reservation.new(check_in_date, check_out_date, room)}
  # let (:invalid_range) { check_out_date <= check_in_date }
  # # let (:bad_date) { Date.new(1985, 12, 15)}
  # let (:rate) {(check_out_date - check_in_date) * RATE}
  before do
    @reservation = Reservation.new(check_in_date, check_out_date, room)
  end

  describe 'initialize' do
    it 'takes a check in date, check out date, and room number' do

      expect(@reservation).must_respond_to :check_in_date
      expect(@reservation.check_in_date).must_equal check_in_date

      expect(@reservation).must_respond_to :check_out_date
      expect(@reservation.check_out_date).must_equal check_out_date

      expect(@reservation).must_respond_to :room
      expect(@reservation.room).must_equal room
    end

    it 'raises an ArgumentError for an invalid date range' do
      expect{ (Rservation.new(invalid_range)) }.must_raise StandardError
    end

    describe 'rate' do
      it 'calculates the rate correctly for a stay in a room' do
        expect(@reservation.rate).must_equal 600
      end
    end
  end
end
