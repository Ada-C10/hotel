require 'simplecov'
SimpleCov.start

require_relative 'spec_helper'

describe 'Reservation' do
  let (:check_in_date) { Date.new(2018, 9, 5) }
  let (:check_out_date) { Date.new(2018, 9, 8) }
  let (:room) { Room.new(15) }
  let (:a_reservation) { Reservation.new(check_in_date, check_out_date, room)}

  describe 'initialize' do
    it 'takes a check in date, check out date, and room number' do

      expect(a_reservation).must_respond_to :check_in_date
      expect(a_reservation.check_in_date).must_equal check_in_date

      expect(a_reservation).must_respond_to :check_out_date
      expect(a_reservation.check_out_date).must_equal check_out_date

      expect(a_reservation).must_respond_to :room
      expect(a_reservation.room).must_equal room
    end
  end
end
