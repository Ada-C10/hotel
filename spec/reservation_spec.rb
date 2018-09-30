require_relative 'spec_helper'

describe "Reservation class" do
  before do
    @reservation = Hotel::Reservation.new({check_in_date: 180904, check_out_date: 180905})
  end

  it "initialize method" do
    expect(@reservation).must_be_kind_of Hotel::Reservation
    expect(@reservation.check_in_date).must_be_kind_of Date
    expect(@reservation.check_out_date).must_be_kind_of Date
  end

  it "raises ArgumentError if check out date is before check in date" do
    expect{(Hotel::Reservation.new(180904, 180903))}.must_raise StandardError
  end

  it "returns all dates in date range" do
    expect(@reservation.date_range).must_be_kind_of Array
    expect(@reservation.date_range.length).must_equal 1
    expect(@reservation.date_range).must_equal [Date.parse("180904")]
  end

  it "returns cost of that date range" do
    expect(@reservation.calculate_booking_cost).must_be_kind_of Integer
    expect(@reservation.calculate_booking_cost).must_equal 200
  end
end
