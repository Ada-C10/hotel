require_relative 'spec_helper'
require 'pry'
require 'date'

describe "ReservationsManager" do
  before do
      @hotel_ada = Hotel::ReservationsManager.new(20)
  end
  describe "Initialize ReservationsManager" do
    it "is an instance of Hotel::ReservationsManager" do
      expect(@hotel_ada).must_be_instance_of Hotel::ReservationsManager
      expect(@hotel_ada.rooms.count).must_equal 20
      expect(@hotel_ada.rooms[0]).must_be_instance_of Hotel::Room
      expect(@hotel_ada.rooms).must_be_kind_of Array
    end
  end
  it "can reserve a room for a given date range" do
    expect(@hotel_ada.reserve_room(start_date, end_date)).must_be_instance_of Hotel::Reservation




  # describe "List all rooms "
end
