require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'spec_helper'
require_relative '../lib/booking_system'
require_relative '../lib/reservation'



describe "initialize" do
  before do
    @dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
  end

  it "is an instance of Reservation" do
    expect(@dates).must_be_kind_of Hotel::DateRange
  end

  it "Takes check_in, check_out" do
    expect(@dates).must_respond_to :check_in
    expect(@dates).must_respond_to :check_out
  end

  it "raises a StandardError if check-out is before check-in " do

    expect {Hotel::reservation.new(check_in, check_out)}.must_raise StandardError
  end

  it "is set up for specific attributes and data types" do
    [:check_in, :check_out].each do |initial|
      expect(@dates).must_respond_to initial
    end
    expect(@dates.check_in).must_be_kind_of Date
    expect(@dates.check_out).must_be_kind_of Date

  end

  describe "date range" do

    it "finds the duration of stay" do
      dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      expect(dates.duration_of_stay).must_equal 3
    end

    it "finds if date ranges overlap" do
      dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      dates2 = Hotel::DateRange.new("2018-04-03", "2018-04-06")
      overlaps = dates2.overlaps?(dates)
      expect(overlaps).must_equal false
    end
    it "finds if ranges overlap if same dates" do
      dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      dates2 = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      overlaps = dates2.overlaps?(dates)
      expect(overlaps).must_equal true
    end
    it "finds if ranges overlap in the front" do
      dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      dates2 = Hotel::DateRange.new("2018-02-03", "2018-02-04")
      overlaps = dates2.overlaps?(dates)
      expect(overlaps).must_equal true
    end
    it "finds if ranges overlap in the back" do
      dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      dates2 = Hotel::DateRange.new("2018-02-05", "2018-02-07")
      overlaps = dates2.overlaps?(dates)
      expect(overlaps).must_equal true
    end
    it "finds if ranges are completely contain" do
      dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      dates2 = Hotel::DateRange.new("2018-02-04", "2018-02-05")
      overlaps = dates2.overlaps?(dates)
      expect(overlaps).must_equal true
    end
    it "finds if ranges are completely containing" do
      dates = Hotel::DateRange.new("2018-02-05", "2018-02-06")
      dates2 = Hotel::DateRange.new("2018-02-04", "2018-02-07")
      overlaps = dates2.overlaps?(dates)
      expect(overlaps).must_equal true
    end

    describe "find if dates are included" do
      before do
        @dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      end
      it "finds if date is included in date range" do
        date_to_find = Date.parse("2018-02-06")
        reservations_by_date = @dates.included_in_date_range(date_to_find)
        expect(reservations_by_date).must_equal true
      end
    end
  end

end
