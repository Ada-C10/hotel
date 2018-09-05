require_relative 'spec_helper'
require 'pry'

describe "Hotel Manager class" do

  describe 'Hotel Manager instantiation' do
    before do
      @hotel = Booking_Manager.new
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
      @hotel = Booking_Manager.new
    end

    it 'returns an Array of rooms in hotel' do
      expect(@hotel.get_rooms).must_be_kind_of Array
      # binding.pry
    end
  end

  # describe 'find_room method' do
  #   before do
  #     @hotel = Booking_Manager.new
  #   end
  #
  #   it 'returns an instance of Room' do
  #     expect(@hotel.find_room(1)).must_be_kind_of Room
  #     expect(@hotel.find_room(20)).must_be_kind_of Room
  #     # binding.pry
  #   end
  #
  #   it 'must be a valid room number 1-20' do
  #     VALID_ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  #     @hotel.rooms.each do |room|
  #       expect(VALID_ROOM_NUMBERS.include?(room.room_number)).must_equal true
  #     end
  #   end
  # end

  describe 'reserve_room method' do
    before do
      @hotel = Booking_Manager.new
    end

    it 'adds a reservation to the array of all reservations' do
      @hotel.reserve_room("Dr. Frankenstein", 6, Date.new(2018, 6, 6), Date.new(2018, 6, 9))

      expect(@hotel.hotel_reservations).must_be_kind_of Array
    end

  end

  describe 'list_reservations method' do
    before do
      @hotel = Booking_Manager.new
      @date = Date.new(2018, 6, 8)
      @reserve1 = @hotel.reserve_room("Dr. Frankenstein", 6, Date.new(2018, 6, 6), Date.new(2018, 6, 9))
      @reserve2 = @hotel.reserve_room("Mx. Mummy", 3, Date.new(2018, 6, 6), Date.new(2018, 6, 12))
      @reserve3 = @hotel.reserve_room("Mx. Mummy", 3, Date.new(2018, 7, 6), Date.new(2018, 7, 12))
      @reservations = [@reserve1, @reserve2]
    end

    it 'returns an array of all reservations for that date' do

      expect(@hotel.list_reservations(@date)).must_be_kind_of Array

      @hotel.list_reservations(@date).each do |reservation|
        expect(@reservations.include?(reservation)).must_equal true
      end
    end
  end

  describe 'total_cost_of_stay method' do
    before do
      @hotel = Booking_Manager.new
      @input = {name:"Dr. Frankenstein", room_number: 6,check_in_date: Date.new(2018, 6, 6), check_out_date: Date.new(2018, 6, 9)}
      @reservation = Reservation.new(@input)
    end

    it 'correctly sums the cost of a stay at the hotel' do
      expect(Booking_Manager.total_cost_of_stay(@reservation)).must_equal 600
    end

  end
end
