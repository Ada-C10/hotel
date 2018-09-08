require_relative 'spec_helper'
# require_relative 'calendar'

# TODO: edge case --> multimonth stay??
describe "Calendar" do
    let(:cal) {Hotel::Calendar.new(start_date: "1986-07-29", end_date: "1986-07-31")}

  describe "#initialize" do
    it "can create a new instance of Calendar" do
      expect(cal).must_be_kind_of Hotel::Calendar
    end
    it "correctly loads date attributes" do
      expect(cal.start_date).must_be_kind_of Date
      expect(cal.start_date.strftime('%Y %b %d')).must_equal "1986 Jul 29"

      expect(cal.end_date).must_be_kind_of Date
      expect(cal.end_date.strftime('%Y %b %d')).must_equal "1986 Jul 31"
    end

    it "throws a StandardError if fed improper date format for start or end date" do
    expect {
      Hotel::Calendar.new(
        start_date: "2009,7,2",
        end_date: "2009-7-1"
        )}.must_raise StandardError

    expect {
      Hotel::Calendar.new({
        start_date: "2009-7-2",
        end_date: "2009,7,1"
        })}.must_raise StandardError
    end

    it "throws a StandardError if end date occurs before or on same day as start date" do
    expect {
      Hotel::Calendar.new({
        start_date: "2009-7-2",
        end_date: "2009-7-1"
        })}.must_raise StandardError

    expect {
      Hotel::Calendar.new({
        start_date: "2009-7-1",
        end_date: "2009-7-1"
        })}.must_raise StandardError
    end
  end

  describe "#create_date_range" do
    it "returns an array of Date objects" do
      cal.create_date_range.each do |date|
        expect(date).must_be_kind_of Date
      end
      expect(cal.create_date_range).must_be_kind_of Array
    end

    it "can list all the dates within the range" do
      date1_s = cal.create_date_range[0].strftime('%Y %b %d')
      date2_s = cal.create_date_range[1].strftime('%Y %b %d')

      expect(cal.create_date_range.length).must_equal 2
      expect(date1_s).must_equal "1986 Jul 29"
      expect(date2_s).must_equal "1986 Jul 30"
    end
  end
end
