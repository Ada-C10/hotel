require_relative 'spec_helper'

describe "#initialize method in reservation class" do
  before do
    @reservation = Reservation.new(start_time: Time.parse("2016-08-08"), end_time: Time.parse("2016-08-09"))
  end

  it "is an instance of a reservation" do
    expect(@reservation).must_be_kind_of Reservation
  end

  it "calculate number of nights" do
    expect(@reservation.nights).must_equal 1
  end

  it "calculate cost" do
    expect(@reservation.cost).must_equal 200
  end

  it "raises an Standard error for invalid date range, end time before start time" do
    @reservation = {start_time: Time.parse("2016-08-09"), end_time: Time.parse("2016-08-08")}
    expect{
        Reservation.new(@reservation)
    }.must_raise StandardError
  end
end


  #
