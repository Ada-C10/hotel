require_relative 'spec_helper'

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

    it "Keeps track of reservations" do
    end


  end
end
