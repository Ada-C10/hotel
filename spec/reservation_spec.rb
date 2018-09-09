require_relative 'spec_helper'

describe Reservation do
  let (:reservation) {
    Reservation.new('181202', '181204')
  }
  let (:error_reservation) {
    Reservation.new('181204', '181202')
  }

  describe "#initialize" do
    it "can be instantiated" do
      expect(reservation).must_be_kind_of Reservation
    end
    it "takes check_in and check_out" do
      expect(reservation).must_respond_to :check_in
      expect(reservation).must_respond_to :check_out
    end
    it "converts check_in and check_ou to Date objects" do
      expect(reservation.check_in).must_be_kind_of Date
      expect(reservation.check_out).must_be_kind_of Date
    end
    it "stores number of nights" do
      expect(reservation.number_of_nights).must_equal 2
    end
    it "raises StandardError if given invalid date range" do
      expect(error_reservation).must_raise StandardError, "Invalid date range."
    end
    it "calculates and stores cost" do
      expect(reservation.cost).must_equal 400
    end
  end

  describe "#number_of_nights" do
    it "calculates number of nights" do
      expect(reservation.number_of_nights).must_equal 2
      expect(error_reservation.number_of_nights).must_equal -2
    end
  end

  describe "#get_all_dates" do
    it "returns Array" do
      expect(reservation.get_all_dates).must_be_kind_of Array
    end
    it "contains all dates for reservation" do
      expect(reservation.get_all_dates.length).must_equal 2
      expect(reservation.get_all_dates[0]).must_be_kind_of Date
      expect(reservation.get_all_dates[0]).must_equal reservation.check_in
      expect(reservation.get_all_dates[-1]).must_be_kind_of Date
      expect(reservation.get_all_dates[-1]).must_equal reservation.check_out - 1
    end
  end
end
