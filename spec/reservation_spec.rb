require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'spec_helper'
require_relative '../lib/booking_system.rb'
require_relative '../lib/reservation.rb'


describe "initialize" do
  before do
    @new_res = Hotel::Reservation.new(cost = 600.00)
  end

  it "is an instance of Reservation" do
      expect(@new_res).must_be_kind_of Hotel::Reservation
    end

  it "Takes cost, and reservation_id" do

    expect(@new_res).must_respond_to :cost
    expect(@new_res).must_respond_to :reservation_id

  end


  # raise an error (StandardError) when an invalid date range is provided
  # it "raises a StandardError if check-out is before check-in " do
  #
  #   expect {Hotel::reservation.new(check_in, check_out, cost, reservation_id)}.must_raise StandardError
  # end

  it "is set up for specific attributes and data types" do
    [:cost, :reservation_id].each do |initial|
      expect(@new_res).must_respond_to initial
    end

    expect(@new_res.reservation_id).must_be_kind_of String
    # expect(@new_res.check_in).must_be_kind_of Date
    # expect(@new_res.check_out).must_be_kind_of Date
    expect(@new_res.cost).must_be_kind_of Float
  end
end

describe "make a reservation" do
  before do
    @new_res = Hotel::Reservation.new(cost = 200.00)
  end
  it "generates a reservation ID" do
    expect(@new_res.reservation_id.length).must_equal 7
  end

  # it "finds the duration of stay" do
  #   expect(@new_res.duration_of_stay).must_equal 3
  # end

  it "finds the total cost of reservation" do
    expect(@new_res.total_cost).must_equal 600.00
  end
end
