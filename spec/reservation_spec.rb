require_relative 'spec_helper'

require 'room'
require 'time'

describe "Reservation" do
  before do
    @start_day = "2019-08-08"
    @end_day = "2019-08-10"
    @reservation = Hotel::Reservation.new(Hotel::Room.new(1), @start_day, @end_day)
  end
  describe "Reservation instatiation" do
    it "creates an object in reservation class" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end
    it "must have a start day" do
      expect(@reservation.start_day).must_equal @start_day
    end
    it "must have an end day" do
      expect(@reservation.end_day).must_equal @end_day

    end
    it "must have a room" do
      expect(@reservation.room).must_be_kind_of Hotel::Room

    end
  end
end
