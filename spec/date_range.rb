require_relative 'spec_helper'

describe "DateRange class" do
  
  describe "Date Range initation " do
    before do
      @date_range = Hotel::DateRange.new('2018-09-05', '2018-09-09')
    end

    it "is an instance of Date Range" do
      expect(@date_range).must_be_kind_of Hotel::DateRange
    end


  end
end
