require_relative 'spec_helper'
require 'pry'

describe "Reservation" do
  describe "initialize" do
    #why is before block not working?
    # before do
    #   reservation = Reservation.new(7, "4-17-2018", "4-20-2018")
    # end
    it "Create an instance of reservation" do
      reservation = Reservation.new(7, 4, "2018-4-17", "2018-4-20")
      reservation.must_be_kind_of Reservation
      # binding.pry
    end

    it "keeps track of ID" do
      id = 7
      reservation = Reservation.new(id, 4, "2018-4-17", "2018-4-20")
      reservation.must_respond_to :id
      reservation.id.must_equal 7
    end

    it "keeps track of room number" do
      room = 4
      reservation = Reservation.new(7, room, "2018-4-17", "2018-4-20")
      reservation.must_respond_to :room
      reservation.room.must_equal 4
    end

    it "keeps track of start_date" do
      reservation = Reservation.new(7, 4, "2018-4-17", "2018-4-20")
      reservation.must_respond_to :start_date
      reservation.start_date.must_be_kind_of Date
    end

    it "keeps track of end_date" do
      reservation = Reservation.new(7, 4, "2018-4-17", "2018-4-20")
      reservation.must_respond_to :end_date
      reservation.end_date.must_be_kind_of Date
    end

    it "raises StandardError for invalid date range" do
      expect{Reservation.new(7, 4, "2018-4-17", "2018-4-14")}.must_raise StandardError
    end
  end
end
