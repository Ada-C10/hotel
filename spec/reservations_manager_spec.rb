require_relative 'spec_helper'
require 'pry'

describe "ReservationsManager" do
  describe "Initialize ReservationsManager" do
    it "is an instance of Hotel::ReservationsManager" do
    hotel_ada = Hotel::ReservationsManager.new(20)
      expect(hotel_ada).must_be_instance_of Hotel::ReservationsManager
      expect(hotel_ada.rooms.count).must_equal 20
      expect(hotel_ada.rooms[0]).must_be_instance_of Hotel::Room
      expect(hotel_ada.rooms).must_be_kind_of Array
    end
  end

  # describe "List all rooms "
end
