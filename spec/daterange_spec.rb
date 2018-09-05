require_relative 'spec_helper'
require 'date'

describe 'DateRange' do

  it "Can be initalized" do
    date_range = DateRange.new(Date.new(2018, 9, 1), Date.new(2018, 9, 2))
    expect(date_range).kind_of? Date
  end

  it "Raises an ArgumentError if check_in is not a date" do
    expect{ DateRange.new("Not a date", Date.new(2018, 9, 2)) }.must_raise ArgumentError
  end

  it "Raises an ArgumentError if check_out is not a date" do
    expect{ DateRange.new(Date.new(2018, 9, 2), "Not a date") }.must_raise ArgumentError
  end

  it "Returns true if a date is within a date range" do
    # Given a date
    # Returns true if date is within check_in and check_out
    date_range = DateRange.new(Date.new(2018, 9, 1), Date.new(2018, 9, 2))
    expect(date_range.within_range?(Date.new(2018, 9, 2))).must_equal TRUE
  end

  it "Returns the number of days" do

  end

end
