require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Reservation class" do
  before do
    @reservation = Hotel::Reservation.new(reservation_id: 1, room: nil, start_date: Date.today, end_date: Date.today, price_per_night: 200)
    @system = Hotel::BookingSystem.new
  end

  describe "Reservation instantiation" do
    before do
      @reservation = Hotel::Reservation.new(reservation_id: 5, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 2), price_per_night: 200)
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end
  describe "total cost of reservation" do
    it "accounts for the discounted price when calculating total cost" do
      @reservation = Hotel::Reservation.new(reservation_id: 5, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 2), price_per_night: 200)

      @system.make_block((Date.new(2018,1,1)), (Date.new(2018,1,5)), 1)
      id = @system.reservations[0].reservation_id

      expect(@reservation.total_cost(id)).must_equal 600
    end
  end
end
