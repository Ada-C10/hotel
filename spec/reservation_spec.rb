require_relative 'spec_helper'

describe Reservation do
  let (:reservation) {
    Reservation.new('181202', '181204')
  }
  let (:error_reservation) {
    Reservation.new('181204', '181202')
  }
  let (:months_reservation) {
    Reservation.new('181130', '181204')
  }
  let (:same_reservation) {
    Reservation.new('181130', '181130')
  }
  let (:years_reservation) {
    Reservation.new('181230', '190103')
  }
  let (:date_error1) {
    Reservation.new('181202', '1812045')
  }
  let (:date_error2) {
    Reservation.new('18120', '181204')
  }
  let (:date_error3) {
    Reservation.new('18-12-02', '1812045')
  }

  describe "#initialize" do
    it "can be instantiated" do
      expect(reservation).must_be_kind_of Reservation
    end
    it "stores number of nights" do
      expect(reservation.number_of_nights).must_equal 2
    end
    it "calculates and stores cost" do
      expect(reservation.cost).must_equal 400
    end
  end

  describe "#date_format" do
    before do

    end
    it "converts check_in and check_out strings to Date objects" do
      expect(reservation.check_in).must_be_kind_of Date
      expect(reservation.check_out).must_be_kind_of Date
    end
    it "raises ArgumentError if date is not 6 digits" do
      expect{Reservation.new('181202', '1812045')}.must_raise ArgumentError, "Date format: YYMMDD."

      expect{Reservation.new('18120', '181204')}.must_raise ArgumentError, "Date format: YYMMDD."
    end
    it "raises ArgumentError if date contains non-numeric characters" do
      expect{Reservation.new('18-12-02', '1812045')}.must_raise ArgumentError, "Date format: YYMMDD."
    end
  end

  describe "#number_of_nights" do
    it "calculates accurate number of nights" do
      expect(reservation.number_of_nights).must_equal 2
      expect(months_reservation.number_of_nights).must_equal 4
    end
    it "raises StandardError if check_out is earlier than check_in" do
      expect{Reservation.new('181204', '181202')}.must_raise Reservation::InvalidDateError, "Invalid date range."
    end
    it "raises StandardError if check_out is the same as check_in" do
      expect{Reservation.new('181130', '181130')}.must_raise Reservation::InvalidDateError, "Invalid date range."
    end
  end

  describe "#get_all_dates" do
    it "returns Array" do
      expect(reservation.get_all_dates).must_be_kind_of Array
    end
    it "contains all dates for reservation in same month" do
      reservation.get_all_dates.each do |date|
        expect(date).must_be_kind_of Date
      end

      expect(reservation.get_all_dates.length).must_equal 2
      expect(reservation.get_all_dates[0]).must_equal reservation.check_in
      expect(reservation.get_all_dates[-1]).must_equal reservation.check_out - 1
    end
    it "contains all dates for reservation spanning 2 months" do
      months_reservation.get_all_dates.each do |date|
        expect(date).must_be_kind_of Date
      end

      expect(months_reservation.get_all_dates.length).must_equal 4
      expect(months_reservation.get_all_dates[0]).must_equal months_reservation.check_in
      expect(months_reservation.get_all_dates[-1]).must_equal months_reservation.check_out - 1
    end
    it "contains all dates for reservation spanning 2 years" do
      years_reservation.get_all_dates.each do |date|
        expect(date).must_be_kind_of Date
      end

      expect(years_reservation.get_all_dates.length).must_equal 4
      expect(years_reservation.get_all_dates[0]).must_equal years_reservation.check_in
      expect(years_reservation.get_all_dates[-1]).must_equal years_reservation.check_out - 1
    end
  end
end
