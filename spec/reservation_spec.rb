require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'spec_helper'
require_relative '../lib/booking_system.rb'
require_relative '../lib/reservation.rb'


describe "initialize" do
  it "Takes check_in, check_out, cost, and reservation_id" do

    check_in = "2018-02-03"
    check_out = "2018-02-06"
    cost = 600
    reservation_id = 1337


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

  it "it raises a StandardError if check-out is before check-in " do
          # Arrange
          # make a start time that is after an end time
          # and put those in @trip_data

          # Act
          # Make a new trip with the bad times


          check_in = "2018-02-03"
          check_out = "2018-01-30"
          cost = 600
          reservation_id = 1337


          expect {Hotel::reservation.new(check_in, check_out, cost, reservation_id)}.must_raise StandardError
    
        end


end
