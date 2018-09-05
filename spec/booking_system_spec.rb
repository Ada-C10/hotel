require_relative 'spec_helper'
require 'date'
require 'pry'

describe "BookingSystem class" do

  describe "load rooms" do
    it "loads rooms in an array" do
      @rooms = Hotel::BookingSystem.new.load_rooms
      # binding.pry
      expect(@rooms).must_be_kind_of Array
    end
  end

  describe "make reservation" do
    before do
      @system = Hotel::BookingSystem.new
    end
    it "makes a reservation" do
      @system.make_reservation(Date.new(2018,1,1), Date.new(2018,1,5))
      expect(@system.reservations.length).must_equal 1
      binding.pry

    end

  end

  describe "assign_available_room" do
    it "finds the first available room" do
    end

  end

end
