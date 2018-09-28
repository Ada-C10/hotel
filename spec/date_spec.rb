require_relative 'spec_helper'

describe "DateRange Class" do
  before do
    @start_date = "2018-03-09"
    @end_date = "2018-03-15"
    @range = Hotel::DateRange.new(@start_date, @end_date)
  end

  describe "initializer" do
    it "is an instance of DateRange" do
      expect(@range).must_be_kind_of Hotel::DateRange
    end

    it "raises an error if start time is after end time" do
      expect {
        start_date = "2018-09-12"
        end_date = "2018-09-03"
        Hotel::DateRange.new(start_date, end_date)
      }.must_raise ArgumentError
    end
  end
  describe "Gets date range" do
    it "inputted dates are converted to date range" do
      expect(@range.get_date_range).must_be_kind_of Range
    end
  end

  describe "checks for possible overlapping cases" do
    it "checking overlap method for date that overlap" do
      requested_start = "2018-03-09"
      requested_end = "2018-03-15"

      date2 = Hotel::DateRange.new(requested_start, requested_end)
      date_range2 = date2.get_date_range

      expect(@range.check_overlap?(date_range2)).must_equal true
    end

    it "checking overlap method for dates that don't overlap" do
      requested_start = "2018-03-17"
      requested_end = "2018-03-20"

      date2 = Hotel::DateRange.new(requested_start, requested_end)
      date_range2 = date2.get_date_range

      expect(@range.check_overlap?(date_range2)).must_equal false
    end

    it "checking overlap dates on checkout dates" do
      requested_start = "2018-03-15"
      requested_end = "2018-03-20"

      date2 = Hotel::DateRange.new(requested_start, requested_end)
      date_range2 = date2.get_date_range

      expect(@range.check_overlap?(date_range2)).must_equal false
    end
  end

  describe "checks if a single date is included" do

    it "checks if a single date is in the rang of dates for reservation" do
      date = "2018-03-10"

      expect(@range.check_include?(date)).must_equal true
    end

    it "single date check when date is not in range" do
      date = "2018-04-10"
      expect(@range.check_include?(date)).must_equal false
    end
  end

  describe "accurately calculates duration" do

    it "calculates duration accurately in days" do
      expect(@range.duration_cal).must_equal 6
    end
  end
end
