require_relative 'spec_helper'
require 'pry'
require 'date'

describe "tests for various pieces in each incidence of reservation" do

  before do
    start_date = Date.new(2018,2,3)
    end_date = Date.new(2018,2,5)
    available_room = 13
    @reservation = Reservation.new(start_date, end_date, available_room)
  end

  it "is an instance of Reservation" do
    expect(@reservation).must_be_kind_of Reservation
  end

  it "will create correctly calculate the duration of the reservation" do

    expect(@reservation.reservation_duration).must_equal 2
  end

  it "will create correctly calculate the cost of the reservation" do

    expect(@reservation.cost).must_equal 400
  end

  it "is set up for specific attributes and data types" do

    expect(@reservation.cost).must_be_kind_of Float
    expect(@reservation.reservation_duration).must_be_kind_of Integer
    expect(@reservation.start_date).must_be_kind_of Date
    expect(@reservation.end_date).must_be_kind_of Date

  end
end
