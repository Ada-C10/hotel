require_relative 'spec_helper'
require 'pry'

describe "DateRange class" do

  describe "validate" do

    it "must throw an argument error if the end date is before the start date" do

      start_date = Date.new(2015, 03, 05)
      end_date = Date.new(2015, 03, 01)

      room_id = 4

      expect {Hotel::DateRange.new(start_date, end_date)}.must_raise ArgumentError

    end
  end


  describe "create date array" do

    before do
      start_date = Date.new(2018,01,06)
      end_date = Date.new(2018,01,10)

      dates = Hotel::DateRange.new(start_date, end_date)

      @date_array = dates.create_date_array(start_date, end_date)

      @test_dates = []

      until start_date == end_date
        @test_dates << start_date
        start_date +=1
      end

    end

    it "returns an array of all dates" do
      expect(@date_array).must_be_kind_of Array
      expect(@date_array.length).must_equal @test_dates.length
    end

    it "includes all dates in the reservation, not including the end date" do
      expect(@date_array).wont_include @end_date
      expect(@date_array).must_equal @test_dates

    end
  end

end
