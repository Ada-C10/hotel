require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Reservation class" do

  describe "Reservation instantiation" do
    before do
      @reservation = Hotel::Reservation.new(id: 5, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 2), price_per_night: 200)
    end

    it "is an reservation of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end
end
