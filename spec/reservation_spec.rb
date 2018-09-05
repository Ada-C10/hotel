# Jacquelyn Cheng - Nodes

# Tests for reservation.rb

require_relative 'spec_helper.rb'

describe "Reservation" do
  before do
    @start_date = "2019-02-01"
    @end_date = "2019-02-05"
    @reservation = Hotel::Reservation.new(@start_date, @end_date, Hotel::Room.new(1))
  end

  describe "Reservation#initialize" do
    it "instantiates a Reservation object" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "has a start date" do
      expect(@reservation.start_date).must_equal @start_date
    end

    it "has an end date" do
      expect(@reservation.end_date).must_equal @end_date
    end

    it "has a room assigned" do
      expect(@reservation.room).must_be_instance_of Hotel::Room
    end

  end
end
