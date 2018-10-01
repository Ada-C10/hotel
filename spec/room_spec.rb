require_relative 'spec_helper'
require 'pry'

describe "Room Class" do
  describe "Initialize Room" do
    it "is an instance of Hotel::Room" do

      hotel_room = Hotel::Room.new(1)
      expect(hotel_room).must_be_instance_of Hotel::Room
      expect(hotel_room.reservations).must_be_kind_of Array
    end
  end
  # wave 2 describe "is_available method" do
  #   it "checks to see which rooms are available for a given date range" do
  #     expect(hotel_room.is_available(check_in: '08-23-2018', check_out: '08-25-2018')).must_be_kind_of Array
  #
  #   end
end
