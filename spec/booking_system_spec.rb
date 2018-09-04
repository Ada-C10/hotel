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
end
