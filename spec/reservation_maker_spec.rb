equire_relative 'spec_helper'
require 'pry'
require 'date'

describe "tests for various pieces in each incidence of ReservationMaker" do

  before do
    start_date = Date.new(2018,2,3)
    end_date = Date.new(2018,2,5)
    @new_reservation = ReservationMaker.new(start_date, end_date)
  end

  it "is an instance of ReservationMaker" do
    expect(@new_reservation).must_be_kind_of ReservationMaker
  end

  it "is set up for specific attributes and data types" do

    expect(@new_reservation.reservation).must_be_kind_of Hash
    expect(@new_reservation.start_date).must_be_kind_of Date
    expect(@new_reservation.end_date).must_be_kind_of Date

  end
end
