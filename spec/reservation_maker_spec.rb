require_relative 'spec_helper'
require 'pry'
require 'date'

describe "tests for various pieces in each incidence of ReservationMaker" do

  before do
    start_date = Date.new(2018,2,3)
    end_date = Date.new(2018,2,5)
    available_room = 13
    @example = ReservationMaker.new(start_date, end_date)
  end

  it "is an instance of ReservationMaker" do
    expect(@example).must_be_kind_of ReservationMaker
  end

  it "is set up for specific attributes and data types" do

    expect(@example.create_reservation).must_be_kind_of Array
    expect(ReservationMaker.reservations).must_be_kind_of Array
    expect(ReservationMaker.reservations[0]).must_be_kind_of Hash
    expect(@example.start_date).must_be_kind_of Date
    expect(@example.end_date).must_be_kind_of Date

  end
end
