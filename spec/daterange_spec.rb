require_relative 'spec_helper'
require 'date'

describe 'DateRange' do
  before do
    @date_range = DateRange.new(Date.new(2018, 9, 1), Date.new(2018, 9, 2))
  end

  it "Can be initalized" do
    expect(@date_range).kind_of? Date
  end

  describe "has the correct instance variables" do
    before do
      START_DATE = Date.new(2018, 9, 1)
      END_DATE = Date.new(2018, 9, 2)
      @date_range = DateRange.new(START_DATE, END_DATE)
    end

    it "Takes a check_in and check_out date" do
      expect(@date_range).must_respond_to :check_in
      expect(@date_range.check_out).must_equal END_DATE
      expect(@date_range).must_respond_to :check_in
      expect(@date_range.check_out).must_equal END_DATE
    end

  end

  it "Raises an ArgumentError if check_in is not a date" do
    expect{ DateRange.new("Not a date", Date.new(2018, 9, 2)) }.must_raise ArgumentError
  end

  it "Raises an ArgumentError if check_out is not a date" do
    expect{ DateRange.new(Date.new(2018, 9, 2), "Not a date") }.must_raise ArgumentError
  end

  ### SHOWING AS NOT COVERED IN COVERAGE PERCENTAGE? ###
  it "Returns true if a date is within a date range" do
    # Returns true if date is within check_in and check_out
    expect(@date_range.within_range?(Date.new(2018, 9, 2))).must_equal TRUE
  end

  it "Returns false if a date is not within a date range" do
    expect(@date_range.within_range?(Date.new(2018, 9, 6))).must_equal FALSE
  end

  it "Returns the number of days" do
    expect(@date_range.number_of_days).must_equal 1
    expect(@date_range.number_of_days).kind_of? Integer
  end

end
