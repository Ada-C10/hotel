require_relative 'spec_helper'

describe Reservation do
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
    skip
    expect(@reservation.cost).must_equal 200
  end

end
