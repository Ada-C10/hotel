require_relative 'spec_helper'
require_relative '../lib/reservation'
require_relative '../lib/date_range'

describe "a reservation" do
  before do
    room_number = 12
    room_price = 200
    @check_in = Date.new(2018, 8, 24)
    @check_out = @check_in + 5
    @stay_duration = Hotel::DateRange.new(@check_in, @check_out)
    @reservation = Hotel::Reservation.new(room_number, room_price, @stay_duration)
  end

  it "creates a new reservation" do
    @reservation.must_be_kind_of Hotel::Reservation
  end

  it "each reservation has a room" do
    @reservation.must_respond_to :room_number
  end

  it "each reservation has a room" do
    @reservation.must_respond_to :room_price
  end

  it "each reservation has a stay duration" do
    @reservation.must_respond_to :stay_duration
  end

  it "calculates total cost of stay" do
    @reservation.stay_total_cost.must_equal 1000
  end

  it "checks to see if a given date is within a reservation" do
    @reservation.within_reservation?(@check_in).must_equal true
  end

  it "does not return true if check in date is after check out date" do
    wrong_date = Date.new(2020, 8, 24)
    @reservation.within_reservation?(wrong_date).must_equal false
  end

end
