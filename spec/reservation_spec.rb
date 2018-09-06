require 'pry'

require_relative 'spec_helper'

describe "Reservation Class" do
  let (:date_range) { Hotel::DateRange.new('2018-09-01', '2018-09-05') }
  let (:reservation) { Hotel::Reservation.new(date_range, 20)}

  # describe "initialize" do
  #   it 'Stores duration as an object' do
  #     expect(reservation.duration).must_be_kind_of Hotel::Duration
  #   end

  describe "total_cost" do

    it 'Calculates total cost of an entire stay' do
      # binding.pry
      expect(reservation.total_cost).must_equal 800.00
    end

    it 'Correctly formats the cost to two decimal places' do
    end

  end
end
