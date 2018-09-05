require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'spec_helper'
require_relative '../lib/booking_system.rb'
require_relative '../lib/reservation.rb'


describe "initialize" do
  before do
    @new_res = Hotel::Reservation.new(check_in = "2018-02-03" , check_out = "2018-02-06", cost = 600, reservation_id = "603-XOX")
  end
  it "Takes check_in, check_out, cost, and reservation_id" do

    check_in = "2018-02-03"
    check_out = "2018-02-06"
    cost = 600
    reservation_id = "603-XOX"


    reservation = Hotel::Reservation.new(check_in, check_out, cost, reservation_id)

    expect(reservation).must_respond_to :check_in
    expect(reservation.check_in.to_s).must_equal check_in

    expect(reservation).must_respond_to :check_out
    expect(reservation.check_out.to_s).must_equal check_out

    expect(reservation).must_respond_to :cost
    expect(reservation.cost).must_equal cost

    expect(reservation).must_respond_to :reservation_id
    expect(reservation.reservation_id).must_equal reservation_id
  end

  # raise an error (StandardError) when an invalid date range is provided
  it "raises a StandardError if check-out is before check-in " do

    check_in = "2018-02-03"
    check_out = "2018-01-30"
    cost = 600
    reservation_id = "603-XOX"


    expect {Hotel::reservation.new(check_in, check_out, cost, reservation_id)}.must_raise StandardError
  end

  it "is set up for specific attributes and data types" do
    [:check_in, :check_out, :cost, :reservation_id].each do |prop|
      expect(@new_res).must_respond_to prop
    end

    expect(@new_res.reservation_id).must_be_kind_of String
    expect(@new_res.check_in).must_be_kind_of Date
    expect(@new_res.check_out).must_be_kind_of Date
    expect(@new_res.cost).must_be_kind_of Float
  end
end

# describe "make a reservation" do
#   it "generates a reservation ID" do
#
#     check_in = "2018-02-03"
#     check_out = "2018-01-30"
#     cost = 600
#     reservation_id = "603-XOX"
#
#     expect(@user.name).must_be_kind_of String
#   end



# end
