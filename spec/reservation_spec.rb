require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Reservation class" do
  before do
    date_range = {}
    date_range[:begin_date] = Date.new(2018,9,1)
    date_range[:end_date] = Date.new(2018,9,15)
    @reservation = Reservation.new(date_range, 5, 200)
  end

  describe "Creates a new reservation"do
    it "creates an instance of a reservation" do
      expect(@reservation).must_be_kind_of Reservation
    end
  end

  describe "Calculates the cost of a reservation" do
    it "correctly calculates the cost of a reservation" do
      expect(@reservation.cost).must_equal 2800
    end
  end
end
