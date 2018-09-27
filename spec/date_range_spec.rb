require_relative 'spec_helper'

describe "DateRange class" do
  before do
    @date = '9-10-2018'
    @date_range = {begin_date: '9-10-2018', end_date: '10-10-2018'}
  end

  it "changes string date into instance of Date class" do
    expect (DateRange::date_parse(@date)).must_be_kind_of Date
  end

  it "takes in begin_date and end_date and creates instances of Date classes of each" do
    date_range_transformed = DateRange::date_range_parse(@date_range)
    expect (date_range_transformed[:begin_date]).must_be_kind_of Date
    expect (date_range_transformed[:end_date]).must_be_kind_of Date
  end

  it "must raise ArgumentError for invalid dates" do
    expect { DateRange::date_range_parse(begin_date: '10-10-2018', end_date: '9-15-2018')}.must_raise ArgumentError
  end

  it "returns true for overlapping dates" do
    date1 = DateRange::date_range_parse(begin_date: '10-10-2018', end_date: '10-20-2018')
    date2 = DateRange::date_range_parse(begin_date: '10-09-2018', end_date: '10-10-2018')
    date3 = DateRange::date_range_parse(begin_date: '10-09-2018', end_date: '10-15-2018')
    date4 = DateRange::date_range_parse(begin_date: '10-15-2018', end_date: '10-25-2018')
    date5 = DateRange::date_range_parse(begin_date: '10-20-2018', end_date: '10-25-2018')

    expect (DateRange.date_overlap?(date1, date2)).must_equal false
    expect (DateRange.date_overlap?(date1, date3)).must_equal true
    expect (DateRange.date_overlap?(date1, date4)).must_equal true
    expect (DateRange.date_overlap?(date1, date5)).must_equal false
  end
end
