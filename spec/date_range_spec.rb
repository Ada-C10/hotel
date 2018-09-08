require_relative 'spec_helper'

describe "DateRange class" do

  describe "Date Range initation " do
    before do
      @date1 = Date.parse('2018-09-05')
      @date2 = Date.parse('2018-09-09')
      @date3 = Date.parse('2018-09-10')
      @date4 = Date.parse('2018-09-11')

      @date_range1 = Hotel::DateRange.new(@date1, @date2)
      @date_range2 = Hotel::DateRange.new(@date1, @date3)
      @date_range3 = Hotel::DateRange.new(@date2, @date3)
      @date_range4 = Hotel::DateRange.new(@date3, @date4)
    end

    it "is an instance of Date Range" do
      expect(@date_range1).must_be_kind_of Hotel::DateRange
    end

    it "it passes Dates as arguments" do
      expect(@date_range1.check_in).must_be_kind_of Date
      expect(@date_range2.check_out).must_be_kind_of Date
    end

    it "it creates an array of Dates between check_in and check_out & excluding check_out" do
      expect(@date_range3.dates_booked).must_be_kind_of Array
      expect(@date_range3.dates_booked.length).must_equal 1
      expect(@date_range3.dates_booked[0]).must_equal @date2
    end

  end
end
