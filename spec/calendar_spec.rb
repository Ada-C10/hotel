require_relative 'spec_helper'
require 'pry'

describe Calendar do

  describe "#initalize" do
    before do
      @calendar = Calendar.new
      @reservation = Reservation.new('181202', '181204')
      @reservation2 = Reservation.new('181102', '181105')
    end
    it "can be instantiated" do
      expect(@calendar).must_be_kind_of Calendar
    end
    it "stores rooms constant" do
      expect(Calendar::ROOMS).must_be_kind_of Array
      expect(Calendar::ROOMS[0]).must_equal 1
    end
  end

  describe "#available_room?" do
    before do
      @calendar = Calendar.new
      @reservation = Reservation.new('181202', '181204')
      @calendar.add_reservation(@reservation)
      # binding.pry
      @reservation2 = Reservation.new('181202', '181204')
      @reservation3 = Reservation.new('181204', '181206')
      @reservation4 = Reservation.new('181203', '181204')
    end
    it "returns false if room is reserved for given dates" do

      # binding.pry
      expect(@calendar.available_room?(1, @reservation2)).must_equal false
    end
    it "returns true if room isn't reserved for given dates" do
      expect(@calendar.available_room?(1, @reservation3)).must_equal true
      # expect(@calendar.available_room?(1, @reservation4)).must_equal false
    end
  end

  describe "#list_available_rooms" do
    before do
      @calendar = Calendar.new
      @reservation = Reservation.new('181202', '181204')
      @calendar.add_reservation(@reservation)
      @list = @calendar.list_available_rooms(@reservation)
    end
    it "returns array of available rooms" do
      expect(@list).must_be_kind_of Array
      expect(@list.length).must_equal 19
      expect(@list.first).must_equal 2
    end
  end

  describe "#add_reservation" do
    before do
      @calendar = Calendar.new
      @reservation = Reservation.new('181202', '181204')
      @reservation2 = Reservation.new('181202', '181204')
      @reservation3 = Reservation.new('181202', '181204')
      @calendar.add_reservation(@reservation)
      @calendar.add_reservation(@reservation2)
      @calendar.add_reservation(@reservation3)
    end
    it "adds all reservation dates to first available room" do
      expect(@calendar.room_assignments[1]).must_equal @reservation.get_all_dates
      expect(@calendar.room_assignments[2]).must_equal @reservation2.get_all_dates
      expect(@calendar.room_assignments[3]).must_equal @reservation3.get_all_dates
    end
    it "returns 'Added!' message" do
      expect(@calendar.add_reservation(@reservation)).must_equal "Added!"
    end
  end
end
  # end
  # end
