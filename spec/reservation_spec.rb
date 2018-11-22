require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'spec_helper'
require_relative '../lib/booking_system.rb'
require_relative '../lib/reservation.rb'


describe "initialize" do
  before do
    @new_res = Hotel::Reservation.new(1, 200.00, "2018-02-03", "2018-02-06")
  end

  it "is an instance of Reservation" do
      expect(@new_res).must_be_kind_of Hotel::Reservation
    end

  it "Takes cost, and reservation_id" do

    expect(@new_res).must_respond_to :cost_per_night
    expect(@new_res).must_respond_to :reservation_id

  end

  it "is set up for specific attributes and data types" do
    [:cost_per_night, :reservation_id].each do |initial|
      expect(@new_res).must_respond_to initial
    end

    expect(@new_res.reservation_id).must_be_kind_of String
    expect(@new_res.cost_per_night).must_be_kind_of Float
  end
end

describe "make a reservation" do
  before do
    @new_res = Hotel::Reservation.new(1, 200.00, "2018-02-03", "2018-02-06")
  end
  it "generates a reservation ID" do
    expect(@new_res.reservation_id.length).must_equal 7
  end


  it "finds the total cost of reservation" do
    expect(@new_res.total_cost).must_equal 600.00
  end

  # it "finds the total cost of each room in a block" do
  #   expect(@new_res.discounted_rate).must_equal 480
  # end
end
