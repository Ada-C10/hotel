require_relative 'spec_helper'

describe "DateRange" do
  let (:start_date) {
    "2018-10-07"
  }
  let (:end_date) {
    "2018-10-16"
  }
  let(:all_dates) {
    Hotel::DateRange.create_date_array(start_date: start_date, end_date: end_date)
  }

  describe "Create_date_array" do
    it "Returns an array of Date instances" do
      expect(all_dates).must_be_kind_of Array

      all_dates.each do |date|
        expect(date).must_be_kind_of Date
      end
    end

    it "Returns an accurate number of days" do
      expect(all_dates.length).must_equal 9
    end

    it "Raises a StandardError with invalid date range" do
      expect{
        Hotel::DateRange.create_date_array(start_date: end_date, end_date: start_date)
      }.must_raise StandardError
    end
  end
end
