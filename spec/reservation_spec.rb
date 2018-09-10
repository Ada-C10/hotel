require 'simplecov'
SimpleCov.start
require 'pry'
require 'time'

require_relative 'spec_helper'

describe 'Reservation' do
  describe 'initialize' do
      check_in_date = Date.new(2018, 9, 5)
      check_out_date = Date.new(2018, 9, 8)
      room_number = Room.new(15)
      reservation = Reservation.new(check_in_date, check_out_date, room_number)

    it 'takes a check in date, check out date, and room number' do

      expect(reservation).must_respond_to :check_in_date
      expect(reservation.check_in_date).must_equal check_in_date

      expect(reservation).must_respond_to :check_out_date
      expect(reservation.check_out_date).must_equal check_out_date

      expect(reservation).must_respond_to :room_number
      expect(reservation.room_number).must_equal room_number
    end

    it 'raises an ArgumentError for an invalid date range' do
      expect{ (Reservation.new(check_out_date, check_in_date)) }.must_raise StandardError
    end
  end

  describe 'nights stayed method' do
      check_in_date = Date.new(2018, 9, 6)
      check_out_date = Date.new(2018, 9, 10)
      room_number = 15
      reservation = Reservation.new(check_in_date, check_out_date, room_number)

    it 'calculates the number of nights stayed correctly' do

      expect(reservation.nights_stayed).must_equal 4
    end
  end
end
