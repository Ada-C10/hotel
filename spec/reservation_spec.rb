require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Reservation" do
  before do
    room_number = 1,
    check_in = Date.new(2018, 9, 01),
    check_out = Date.new(2018, 9, 02),
    @test_reservation = Reservation.new(1, check_in, check_out)
    @manager = Booking.new
  end

  it "Is an instance of Reservation" do
    expect(@test_reservation).kind_of? Reservation
  end

  it "Check in is a date" do
    expect(@test_reservation.check_in).kind_of? Date
    expect(@test_reservation).respond_to? :check_in
    expect(@test_reservation.check_in).must_equal Date.new(2018, 9, 01)
  end

  it 'raises an ArgumentError if check_in is not a date' do
    expect{Reservation.new(1, "Invalid", Date.new(1-1-2018)) }.must_raise ArgumentError
  end

  it "Has a checkout" do
    expect(@test_reservation.check_out).kind_of? Date
    expect(@test_reservation).must_respond_to :check_out
  end

  it 'raises an ArgumentError if check_out is not a date' do
    expect{Reservation.new(1, Date.new(1-1-2018), "Invalid") }.must_raise ArgumentError
  end

  it "Has a room number" do
    expect(@test_reservation.room_number).must_equal 1
    expect(@test_reservation).must_respond_to :room_number
  end

  it "Has a cost" do
    expect(@test_reservation.cost_per_night).must_equal 200
    expect(@test_reservation).must_respond_to :cost_per_night
  end

  it "Has a valid cost" do
    @test_reservation = Reservation.new(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))
    expect(@test_reservation.reservation_cost).must_equal 200
  end

  it "Correctly counts the number of days" do
    expect(@test_reservation.number_of_days_reserved).must_equal (@test_reservation.check_out - @test_reservation.check_in).to_i
    expect(@test_reservation).kind_of? Integer
  end

  describe "BlockRoom" do
    it "Is able to check if a date range is reserved for a BlockRoom" do
      # Would be a helper method of some sort for Room to check Reservation to see if date range has been reserved for a BlockRoom
    end
  end
end
