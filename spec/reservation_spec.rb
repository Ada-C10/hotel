require_relative 'spec_helper'
require 'pry'

describe "Reservation Class" do
  let (:date_range) { Hotel::DateRange.new('2018-09-01', '2018-09-05') }
  let (:reservation) { Hotel::Reservation.new(date_range, 1)}

  describe "Initializer" do
    it 'Is an instance of Reservation' do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it 'Takes date range as an instance of DateRange' do
      expect(reservation.date_range).must_be_kind_of Hotel::DateRange
    end

    it 'Takes room number as an integer' do
      expect(reservation.room_number).must_equal 1
    end
  end

  describe 'number_of_nights method' do
    it 'Returns the correct number of nights' do
      expect(reservation.number_of_nights).must_equal 4
    end
  end

  describe "total_cost" do
    it 'Calculates total cost of an entire stay' do
      expect(reservation.total_cost).must_equal 800.00
    end

    # it 'Correctly formats the cost to two decimal places' do
    #   expect(reservation.total_cost).myst
    # end

  end
end
