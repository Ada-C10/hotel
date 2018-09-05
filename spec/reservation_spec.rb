require 'pry'

require_relative 'spec_helper'

describe "Reservation Class" do
  let (:duration) { Hotel::Duration.new('2018-09-01', '2018-09-05') }
  let (:reservation) { Hotel::Reservation.new(1, duration, 20) }

  describe "initailize" do
    it 'Stores duration as an object' do
      expect(reservation.duration).must_be_kind_of Hotel::Duration
    end

  describe "total_cost" do

    it 'Calculates total cost of an entire stay' do
      expect(reservation.total_cost).must_equal 800.00
    end

    it 
  end
  end
end
