require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Reservation" do
  before do
    @test_reservation = Reservation.new(1, Date.new(2018, 9, 01), Date.new(2018, 9, 02))
  end

  it "Is an instance of Reservation" do
    expect(@test_reservation).kind_of? Reservation
  end

  it "Check in is a date" do
    expect(@test_reservation.check_in).kind_of? Date
  end

  it 'raises an ArgumentError if check_in is not a date' do
    expect{Reservation.new(1, "Invalid", Date.new(1-1-2018)) }.must_raise ArgumentError
  end

  it "Has a checkout" do
    expect(@test_reservation.check_out).kind_of? Date
  end

  it 'raises an ArgumentError if check_out is not a date' do
    expect{Reservation.new(1, Date.new(1-1-2018), "Invalid") }.must_raise ArgumentError
  end

  it "Has a room number" do
    expect(@test_reservation.room_number).must_equal 1
  end

  it "Has a cost" do
    expect(@test_reservation.cost_per_night).must_equal 200
  end

  it "Has a valid total" do
    @test_reservation = Reservation.new(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))
    expect(@test_reservation.reservation_cost).must_equal 200
  end

  it "Correctly counts the number of days" do
    expect(@test_reservation.number_of_days_reserved).must_equal 1
  end

  it "Is able to find associated room based on room number" do
    skip
    @room = Room.new(1,[] )
    expect(@test_reservation.find_room).must_equal @room
  end

  it "Has an error if attempting to book a reserved room" do
    skip
  end

  it "Adds a reservation if a valid reservation is made" do
    # Need to setup a room

    # Need to setup reservation


  end

end
