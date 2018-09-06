require_relative 'spec_helper'
require 'pry'

describe "BlockReservation" do
  describe "initialize" do
    it "creates an instance of a block reservation" do

      family_reunion = BlockReservation.new(7, [2,4,6], "2018-4-17", "2018-4-20")
      # binding.pry
      family_reunion.must_be_kind_of BlockReservation
    end

    it "keeps track of ID" do
      id = 7
      family_reunion = BlockReservation.new(id, [2,4,6], "2018-4-17", "2018-4-20")
      family_reunion.must_respond_to :id
      family_reunion.id.must_equal 7
    end

    it "keeps track of room number" do
      rooms = [2, 4, 6]
      family_reunion = BlockReservation.new(7, [2,4,6], "2018-4-17", "2018-4-20")
      family_reunion.must_respond_to :rooms
      family_reunion.rooms.must_equal [2, 4, 6]
    end

    it "keeps track of start_date" do
      family_reunion = BlockReservation.new(7, [2,4,6], "2018-4-17", "2018-4-20")
      family_reunion.must_respond_to :start_date
      family_reunion.start_date.must_equal Date.parse("2018-4-17")
    end

    it "keeps track of end_date" do
      family_reunion = BlockReservation.new(7, [2,4,6], "2018-4-17", "2018-4-20")
      family_reunion.must_respond_to :end_date
      family_reunion.end_date.must_equal Date.parse("2018-4-20")
    end

    it "raises StandardError for invalid date range" do
      expect{BlockReservation.new(7, 4, "2018-4-17", "2018-4-14")}.must_raise StandardError
    end
  end
end
