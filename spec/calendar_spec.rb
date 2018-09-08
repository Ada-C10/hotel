require_relative 'spec_helper'
# require_relative 'calendar'

# TODO: edge case --> multimonth stay??
describe "Calendar" do
    let(:cal) {Hotel::Calendar.new(check_in: "1986-07-20", check_out: "1986-07-29")}

  describe "#initialize" do
    it "can create a new instance of Calendar" do
      expect(cal).must_be_kind_of Hotel::Calendar
    end
    it "correctly loads date attributes" do
      expect(cal.check_in).must_be_kind_of Date
      expect(cal.check_in.strftime('%Y %b %d')).must_equal "1986 Jul 20"

      expect(cal.check_out).must_be_kind_of Date
      expect(cal.check_out.strftime('%Y %b %d')).must_equal "1986 Jul 29"
    end

    it "throws a StandardError if fed improper date format for start or end date" do
    expect {
      Hotel::Calendar.new(
        check_in: "2009,7,2",
        check_out: "2009-7-1"
        )}.must_raise StandardError

    expect {
      Hotel::Calendar.new({
        check_in: "2009-7-2",
        check_out: "2009,7,1"
        })}.must_raise StandardError
    end

    it "throws a StandardError if end date occurs before or on same day as start date" do
    expect {
      Hotel::Calendar.new({
        check_in: "2009-7-2",
        check_out: "2009-7-1"
        })}.must_raise StandardError

    expect {
      Hotel::Calendar.new({
        check_in: "2009-7-1",
        check_out: "2009-7-1"
        })}.must_raise StandardError
    end
  end

  # describe "#create_date_range" do
  #   it "returns an array of Date objects" do
  #     cal.create_date_range.each do |date|
  #       expect(date).must_be_kind_of Date
  #     end
  #     expect(cal.create_date_range).must_be_kind_of Array
  #   end
  #
  #   it "can list first and last dates within range" do
  #     date1_s = cal.create_date_range[0].strftime('%Y %b %d')
  #     date2_s = cal.create_date_range[-1].strftime('%Y %b %d')
  #
  #     expect(cal.create_date_range.length).must_equal 9
  #     expect(date1_s).must_equal "1986 Jul 20"
  #     expect(date2_s).must_equal "1986 Jul 29"
  #   end
  # end

  describe "#overlap?" do
    it "returns false for no overlap: other dates begin and end before reserved dates" do
      other_dates = Hotel::Calendar.new(check_in: "1986-07-01", check_out: "1986-07-15")

      dates_overlap = cal.overlap?(other_dates)

      expect(dates_overlap).must_equal false
    end

    it "returns false for no overlap: other dates begin and end after reserved dates" do
      other_dates = Hotel::Calendar.new(check_in: "1986-07-30", check_out: "1986-07-31")

      dates_overlap = cal.overlap?(other_dates)

      expect(dates_overlap).must_equal false
    end

    it "returns false for no overlap: other dates begin during reserved dates' check out date" do
      # edge case
      other_dates = Hotel::Calendar.new(check_in: "1986-07-29", check_out: "1986-07-31")

      dates_overlap = cal.overlap?(other_dates)

      expect(dates_overlap).must_equal false
    end

    it "returns false for no overlap: other dates end during reserved dates' check in date" do
      # edge case
      other_dates = Hotel::Calendar.new(check_in: "1986-07-15", check_out: "1986-07-20")

      dates_overlap = cal.overlap?(other_dates)

      expect(dates_overlap).must_equal false
    end

    it "returns true if dates overlap: other dates begin and end beyond reserved dates range" do
      other_dates = Hotel::Calendar.new(check_in: "1986-07-01", check_out: "1986-07-31")

      dates_overlap = cal.overlap?(other_dates)

      expect(dates_overlap).must_equal true
    end

    it "returns true if dates overlap: other dates are fully contained within reserved dates" do
      other_dates = Hotel::Calendar.new(check_in: "1986-07-25", check_out: "1986-07-28")

      dates_overlap = cal.overlap?(other_dates)

      expect(dates_overlap).must_equal true
    end

    it "returns true if dates overlap: other dates begin before but end during reserved dates" do
      other_dates = Hotel::Calendar.new(check_in: "1986-07-10", check_out: "1986-07-28")

      dates_overlap = cal.overlap?(other_dates)

      expect(dates_overlap).must_equal true
    end

    it "returns true if dates overlap: other dates begin during but end after reserved dates" do
      other_dates = Hotel::Calendar.new(check_in: "1986-07-25", check_out: "1986-07-31")

      dates_overlap = cal.overlap?(other_dates)

      expect(dates_overlap).must_equal true
    end




  end




end
