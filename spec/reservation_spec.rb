# Jacquelyn Cheng - Nodes

# Tests for reservation.rb

require 'date'
require_relative 'spec_helper.rb'

describe "Reservation" do
  before do
    @start_date = Date.parse("2019-02-01")
    @end_date = Date.parse("2019-02-05")
    @reservation = Hotel::Reservation.new(@start_date, @end_date, Hotel::Room.new(1), 10)
  end

  describe "Reservation#initialize" do
    it "instantiates a Reservation object" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "has a start date" do
      expect(@reservation.checkin_date).must_equal @start_date
    end

    it "has an end date" do
      expect(@reservation.checkout_date).must_equal @end_date
    end

    it "has a room assigned" do
      expect(@reservation.rooms).must_be_instance_of Hotel::Room
    end

    it "has a confirmation number" do
      expect(@reservation.confirmation_number).must_equal 10
    end
  end

  describe "Resevation#total_cost" do
    it "returns a float" do
      expect(@reservation.total_cost).must_be_instance_of Float
    end

    it "correctly calculates cost to two decimal places based on # of nights" do
      expect(@reservation.total_cost).must_equal 800.00
    end
  end
end
