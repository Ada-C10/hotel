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
end
