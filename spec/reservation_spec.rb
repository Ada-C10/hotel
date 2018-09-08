require_relative 'spec_helper'
require 'pry'

describe "Reservation class" do

  describe "Reservation initialization" do

    it "is an instance of Reservation" do
      start_date = Date.new(2015, 03, 01)
      end_date = Date.new(2015, 03, 05)
      @reservation = Hotel::Reservation.new(start_date, end_date, 4)
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end


    it "must throw an argument error if the end date is before the start date" do
      start_date = Date.new(2015, 03, 05)
      end_date = Date.new(2015, 03, 01)
      expect {Hotel::Reservation.new(start_date, end_date)}.must_raise ArgumentError
    end
  end


  describe "reservation cost" do
    it "returns the total amount of the new reservation" do
      start_date = Date.new(2015, 03, 01)
      end_date = Date.new(2015, 03, 05)
      @reservation = Hotel::Reservation.new(start_date, end_date, 3)

      start_date = @reservation.start_date
      end_date = @reservation.end_date

      expect(@reservation.reservation_cost(start_date, end_date)).must_equal 800
    end
  end

end
