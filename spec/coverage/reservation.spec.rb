require_relative 'spec_helper'
require 'pry'

describe "reservation class" do

  describe "room instantiation" do
    before do
      @hotel_rooms = Hotel::HotelRooms.new
  end
