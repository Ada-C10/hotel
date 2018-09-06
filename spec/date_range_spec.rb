require_relative 'spec_helper'

describe "DateRange" do
  let (:check_in) {
    "2018-10-07"
  }
  let (:check_out) {
    "2018-10-16"
  }
  let(:all_dates) {
    all_dates = Hotel::DateRange.create_date_array(check_in, check_out)
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
  end
end
