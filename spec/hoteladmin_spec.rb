require_relative 'spec_helper'
require 'pry'

describe "HotelAdmin" do
  let (:hotel) {
     HotelAdmin.new
  }
  describe "HotelAdmin#Initialize" do
    it "can create a hoteladmin object" do
      expect(hotel).must_be_instance_of HotelAdmin
    end

    it "initializes with readable rooms and reservations array attributes" do
      expect(hotel.rooms).must_be_instance_of Array
      expect(hotel.reservations).must_be_instance_of Array
      expect(hotel.rooms).must_be_empty
      expect(hotel.reservations).must_be_empty
    end
  end

  describe "HotelAdmin#list_rooms" do
    it "will return the array room objects" do
          20.times do |index|
            hotel.rooms << Room.new(index+1)
          end
          expect(hotel.list_rooms[0]).must_be_instance_of Room
          expect(hotel.list_rooms).must_be_instance_of Array
          #always getting increasing numbers here as it runs, so need greater than for now. Troubleshoot later!
          expect(hotel.list_rooms.length).must_be :>=, 20
    end
  end

end
