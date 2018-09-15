require_relative 'spec_helper'
require 'pry'

describe "Reservation class" do

  describe "Reservation initialization" do

    before do
      date_range = [1,2,3]
      @reservation = Hotel::Reservation.new(date_range, 4)
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "is initialized with a date range, room id and total cost" do
      expect(@reservation).must_respond_to :reservation_dates
      expect(@reservation.reservation_dates).must_be_kind_of Array

      expect(@reservation).must_respond_to :room_id
      expect(@reservation.room_id).must_be_kind_of Integer

      expect(@reservation).must_respond_to :total_cost
      expect(@reservation.total_cost).must_be_kind_of Integer

    end
  end


  describe "reservation cost" do
    it "returns the total amount of the new reservation" do

      date_range = [1,2,3,4]
      @reservation = Hotel::Reservation.new(date_range, 3)

      start_date = @reservation.start_date
      end_date = @reservation.end_date

      expect(@reservation.reservation_cost(date_range)).must_equal 800
    end
  end

end
