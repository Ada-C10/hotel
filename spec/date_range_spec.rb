require_relative 'spec_helper'

describe "DateRange class" do
  before do
    @start_date = Date.today
    @end_date = Date.today + 5
    @date_range = Hotel::DateRange.new(@start_date, @end_date)
  end

  describe "initialize" do
    it "is an instance of DateRange" do
      expect(@date_range).must_be_kind_of Hotel::DateRange
    end

    it "raises an error if end date precedes start date" do
      start_date = 'Date.today'
      end_date = 'start_date - 5'
      expect {
        reservation = Hotel::DateRange.new(start_date, end_date)
      }.must_raise StandardError
    end

    it "raises an error if start_date and end_date are both not Date types" do
      start_date = Date.today
      end_date = start_date - 5
      expect {
        reservation = Hotel::DateRange.new(start_date, end_date)
      }.must_raise StandardError
    end

    it "raises an error if start_date is a Date and but end_date is not" do
      start_date = Date.today
      end_date = "Date.today + 5"
      expect {
        reservation = Hotel::DateRange.new(start_date, end_date)
      }.must_raise StandardError
    end

    it "raises an error if start_date not a Date and but end_date is" do
      start_date = "Date.today"
      end_date = Date.today + 5
      expect {
        reservation = Hotel::DateRange.new(start_date, end_date)
      }.must_raise StandardError
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

  describe "#reservation_period method" do
    it "Finds difference between end_date and start_date not including the checkout_date" do
      reservation_period = @end_date - @start_date
      expect(@date_range.find_num_nights).must_be_kind_of Numeric
      expect(@date_range.find_num_nights).must_equal reservation_period
    end
  end
end
