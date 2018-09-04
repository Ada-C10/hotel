require_relative 'spec_helper'
require 'date'

describe "Reservation" do
  before do

  end

  it "Can be created" do
    # Is doing division
    test_reservation = Reservation.new(1, Date.new(9-1-2018), Date.new(9-2-2018)) 
  end

  it "Has a checkin" do
    skip
  end

  it "Has a checkout" do
    skip
  end

  it "Raises an ArgumentError if checkin is before checkout" do
    skip
  end

  it "Has a room number" do
    skip
  end

  it "Has a valid total" do
    skip
  end

  it "Has an error if attempting to book a reserved room" do
    skip
  end

  it "Adds a reservation if a valid reservation is made" do
    skip
  end

end
