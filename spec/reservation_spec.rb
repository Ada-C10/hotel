require_relative 'spec_helper'
require 'date'

describe "Reservation class" do
  before do
    @begin_date = Date.new(2018,9,1)
    @end_date = Date.new(2018,9,15)
    @reservation = Reservation.new(@begin_date, @end_date, 5, 200)
  end

  describe "Creates a new reservation"do
    it "creates an instance of a reservation" do
      expect(@reservation).must_be_kind_of Reservation
    end
  end
end
