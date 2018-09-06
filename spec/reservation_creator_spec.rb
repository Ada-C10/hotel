require_relative 'spec_helper'

describe "Reservation class" do
  before do
    @reservation = Hotel::Reservation.new({check_in_date: 180904, check_out_date: 180905})
  end

  it "initialize method" do
    expect(@reservation).must_be_kind_of Hotel::Reservation
    expect(@reservation.check_in_date).must_be_kind_of Integer
    expect(@reservation.check_out_date).must_be_kind_of Integer
  end

  it "raises ArgumentError if check out date is before check in date" do
    expect{(list = Hotel::Reservation.new(180904, 180903))}.must_raise StandardError
  end

  it "returns array of all dates user wants to book" do
    expect(@reservation.reservation_date_range).must_be_kind_of Array

  end

  it "returns the array of dates except the check out date" do
  expect(@reservation.reservation_date_range).must_equal [Date.parse("180904")]
end
end
