require_relative 'spec_helper'

describe Reservation do
  describe "#initialize" do
    it "can be instantiated" do
      @reservation = Reservation.new(181202, 2)
      expect(@reservation).must_be_kind_of Reservation
    end
    it "takes check_in and number_of_nights" do
      @reservation = Reservation.new(181202, 2)
      expect(@reservation).must_respond_to :check_in
      expect(@reservation).must_respond_to :number_of_nights
    end
    it "converts check_in to Date object" do
      @reservation = Reservation.new(181202, 2)
      expect(@reservation.check_in).must_be_kind_of Date
      # expect(@reservation.check_in).must_equal 2018-12-02
    end
    it "calculates and stores cost" do
      @reservation = Reservation.new(181202, 2)
      expect(@reservation.cost).must_equal 400
      expect(@reservation).must_respond_to :cost
    end
  end
  describe "#get_all_dates" do
    it "returns Array" do
      @reservation = Reservation.new(181202, 2)
      expect(@reservation.get_all_dates).must_be_kind_of Array
    end
    it "contains all dates for reservation" do
      @reservation = Reservation.new(181202, 2)
      expect(@reservation.get_all_dates.length).must_equal 2
      expect(@reservation.get_all_dates[0]).must_be_kind_of Date
      expect(@reservation.get_all_dates[1]).must_be_kind_of Date
    end
  end
end
