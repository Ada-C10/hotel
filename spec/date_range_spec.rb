require_relative 'spec_helper'

describe "DateRange class" do
  before do
    @start_date = Date.today
    @end_date = @start_date + 5
    @date_range = Hotel::DateRange.new(@start_date, @end_date)
  end

  describe "initialize" do
    it "is an instance of DateRange" do
      expect(@date_range).must_be_kind_of Hotel::DateRange
    end
  end

  describe "#overlaps? method (when it does overlap)" do
    it "checks if the range in a reservation overlaps with the requested_dates if the requested_dates for the same dates" do
      start_date = Date.today
      end_date = start_date + 5
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal false
    end

    it "checks if the range in a reservation overlaps with the requested_dates if they do so in the front" do
      start_date = Date.today - 1
      end_date = start_date + 5
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal false
    end

    it "checks if the range in a reservation overlaps with the requested_dates if they do so in the back" do
      start_date = Date.today + 4
      end_date = start_date + 5
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal false
    end

    it "checks if the range in a reservation overlaps with the requested_dates if they are completely contained" do
      start_date = Date.today + 1
      end_date = start_date + 3
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal false
    end

    it "checks if the range in a reservation overlaps with the requested_dates if they are completely containing" do
      start_date = Date.today - 1
      end_date = start_date + 7
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal false
    end
  end

  describe "#overlaps? method (when it does NOT overlap)" do
    it "checks if the requested_dates is completely before the reservation range" do
      start_date = Date.today - 5
      end_date = start_date + 5
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal true
    end

    it "checks if the requested_dates is completely after the reservation range" do
      start_date = Date.today + 10
      end_date = start_date + 5
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal true
    end

    it "checks if the range checkout date does not conflickt with the requested_dates checkin date" do
      start_date = @start_date - 5
      end_date = @start_date
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal true
    end

    it "checks if the range checkin date does not conflict with requested_dates checkout date" do
      start_date = @end_date
      end_date = start_date + 5
      requested_dates = Hotel::DateRange.new(start_date, end_date)
      expect(@date_range.overlaps? requested_dates).must_equal true
    end
  end

  describe "#get_range method" do
    it "returns an array of the range with the first element as the start_date and the last being one day before end_date " do
      expect(@date_range.get_range).must_be_kind_of Array
      expect(@date_range.get_range).must_equal [*@start_date...@end_date]
      expect(@date_range.get_range).must_include @start_date
      expect(@date_range.get_range).wont_include @end_date
      expect(@date_range.get_range).must_include @end_date - 1
    end
  end

  describe "#find_num_nights method" do
    it "Finds difference between end_date and start_date not including the checkout_date" do
      reservation_period = @end_date - @start_date
      expect(@date_range.find_num_nights).must_be_kind_of Numeric
      expect(@date_range.find_num_nights).must_equal reservation_period
    end
  end
end
