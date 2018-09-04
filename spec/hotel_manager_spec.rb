require_relative 'spec_helper'
require 'pry'

describe "Hotel Manager class" do

  describe 'Hotel Manager instantiation' do
    before do
      @hotel = Hotel_Manager.new
    end

    it 'has an array of all rooms in hotel' do
      expect(@hotel.rooms).must_be_kind_of Array
    end

    it 'has 20 rooms in the hotel' do
      expect(@hotel.rooms.length).must_equal 20
    end

    it 'each index of the array is an instance of class' do
      expect(@hotel.rooms[0]).must_be_kind_of Room
      # binding.pry
    end
  end

  describe 'get_room method' do
    before do
      @hotel = Hotel_Manager.new
    end

    it 'returns an Array of rooms in hotel' do
      expect(@hotel.get_rooms).must_be_kind_of Array
      # binding.pry
    end
  end

  describe 'find_room method' do
    before do
      @hotel = Hotel_Manager.new
    end

    it 'returns an instance of Room' do
      expect(@hotel.find_room(1)).must_be_kind_of Room
      expect(@hotel.find_room(20)).must_be_kind_of Room
      # binding.pry
    end
  end

end
