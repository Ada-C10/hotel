require_relative 'spec_helper'
require 'pry'

describe "Reservation class" do

  describe "Reservation instantiation" do
    before do
      @reservation = Hotel::Reservation.new(check_in: "2016-08-08", check_out: "2016-08-09", room_num: 5)
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "raises an error for an invalid room number" do
      expect{Hotel::Reservation.new(room_num: 21)}.must_raise ArgumentError
    end
  end

  describe "reserve_room method" do
    before do
      @reservation = Hotel::Reservation.new
    end

    it "reserve_room method returns a hash" do
      expect(@reservation.reserve_room).must_be_kind_of Hash
    end

    it "Returns accurate information about a reservation" do
      @reservations[:room_num] = 5
    end

  describe "total_cost_reservation method" do
    before do
      @reservation = Hotel::Reservation.new
    end

    it "total_cost_reservation returns a integer" do
      expect(@reservation.total_cost_reservation).must_equal integer
    end
  end
end
