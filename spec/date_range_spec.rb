require_relative 'spec_helper'
require_relative '../lib/date_range'


describe "a date range" do
  before do
    @check_in = Date.new(2018, 8, 24)
    @check_out = @check_in + 5
    @date_range = Hotel::DateRange.new(@check_in, @check_out)

  end

  it "creates a new date range" do
    @date_range.must_be_kind_of Hotel::DateRange
  end

  it "each date range has a start date" do
    @date_range.must_respond_to :start_date
  end

  it "each date range has an end date" do
    @date_range.must_respond_to :end_date
  end

  it "each date range has a duration" do
    @date_range.duration.must_equal 5
  end

  it "each date range must ben an integer" do
    @date_range.duration.must_be_kind_of Integer
  end

  it "raises a standard error if end date is before start date" do
    expect{ Hotel::DateRange.new(@check_out, @check_in) }.must_raise StandardError
  end

  it "checks to see if a given date is within the date range" do

    @date_range.include?(@check_in).must_equal true
  end

  it "returns false if given date is before checkin" do

    @date_range.include?(@check_in - 2).must_equal false
  end

  it "returns true if given date is within date range" do
    @date_range.include?(@check_in + 1).must_equal true
  end

  it "returns false if given date is on the check out day" do
    @date_range.include?(@check_out).must_equal false
  end

  it "returns false if given date is after the check out date" do
    @date_range.include?(@check_out + 1).must_equal false
  end


end
