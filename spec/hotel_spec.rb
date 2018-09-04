require_relative 'spec_helper'
require 'pry'

# # As an administrator, I can access the list of reservations for a specific date
# # hotel.reservations(date)
#
# # As an administrator, I can get the total cost for a given reservation
# # hotel.reservations.find_cost(reservation_id)

describe "Hotel Class: Wave One: Tracking Reservations" do
  describe "hotel class initialize" do
    before do
      @hotel = Hotel.new(20)
    end
    it "creates 20 hotel rooms" do
      expect(@hotel.rooms.length).must_equal 20
    end
    it "each hotel room is an instance of a room" do
      expect(@hotel.rooms[0]).must_be_instance_of Room
    end
  end

  describe "list_rooms" do
    before do
      @hotel = Hotel.new(20)
    end
    it "list_rooms lists all of the rooms" do
      expect(@hotel.list_rooms.length).must_equal 20
    end
  end

  # # As an administrator, I can reserve a room for a given date range
  # # hotel.reserve_room(room_amount, start_date, end_date)
end
