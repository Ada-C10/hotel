require_relative 'spec_helper'
require 'date'

describe "HotelManager" do
  describe "#initialize" do
    it "Creates an instance of Hotel Manager" do
      my_hotel = Hotel::HotelManager.new
      expect(my_hotel).must_be_kind_of Hotel::HotelManager
    end

    it "Creates an array of rooms" do
      my_hotel = Hotel::HotelManager.new
      expect(my_hotel.rooms).must_be_kind_of Array
    end

    it "Keeps track of rooms" do
      my_hotel = Hotel::HotelManager.new

      expect(my_hotel).must_respond_to :rooms

      my_hotel.rooms.each_with_index do |room, i|
        expect(room.id).must_equal (i + 1)
        expect(room).must_be_kind_of Hotel::Room
      end
    end


    # it "Keeps track of reservations" do
    #
    # end
  end

  describe "#reserve" do

  end

  # describe "#available_rooms" do
  #   check_in = "2018-10-07"
  #   check_out = "2018-10-14"
  #   my_hotel = Hotel::HotelManager.new
  #   available_rooms = my_hotel.available_rooms(check_in, check_out)
  # end


  # describe "available_rooms" do
  #   let (:check_in) {
  #     "2018-02-10"
  #   }
  #   let (:check_out) {
  #     "2018-02-16"
  #   }
  #   let (:rooms) {
  #     Hotel::Room.all
  #   }
  #   let (:open_rooms) {
  #     Hotel::Room.available_rooms(check_in, check_out)
  #   }
  #
  #   it "returns an array of Rooms" do
  #     expect(open_rooms).must_be_kind_of Array
  #   end
  #
  #   it "Returns an array full of Rooms" do
  #     open_rooms.each do |room|
  #       expect(room).must_be_kind_of Hotel::Room
  #     end
  #   end
  #
  #   it "Returns the correct number of rooms" do
  #     rooms.first.calendar << Date.parse("2018-02-12")
  #     expect(open_rooms.length).must_equal 19
  #   end
  #
  #   it "returns nil if there are no rooms available" do
  #     rooms.each do |room|
  #       room.calendar << Date.parse("2018-02-12")
  #     end
  #
  #     expect(open_rooms).must_be_nil
  #   end
  # end
end
