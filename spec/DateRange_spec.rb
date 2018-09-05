require_relative 'spec_helper'

describe "DateRange Test" do
  describe "initialize" do
    before do
      @dates = DateRange.new("2018-09-05","2018-09-07")
    end
    it "is an instance of DateRange" do
      expect(@dates).must_be_kind_of DateRange
    end
    it "raises an argument error when Check-in is after Check-out" do
      expect{DateRange.new("2018-09-07","2018-09-05")}.must_raise ArgumentError
    end
  end
end
