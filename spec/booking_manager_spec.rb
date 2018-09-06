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

  describe 'find_room_number method' do
    before do
      @hotel = Booking_Manager.new
    end

    it 'returns an instance of Room' do
      expect(@hotel.find_room_number(1)).must_be_kind_of Room
      expect(@hotel.find_room_number(20)).must_be_kind_of Room
      # binding.pry
    end

    it 'must be a valid room number 1-20' do
      VALID_ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
      @hotel.rooms.each do |room|
        expect(VALID_ROOM_NUMBERS.include?(room.room_number)).must_equal true
      end
    end
  end

  describe 'reserve_room method' do
    before do
      @hotel = Booking_Manager.new
      @input = { name: "Dr. Frankenstein",
        room_number: 6,
        check_in_date: Date.new(2018, 6, 6),
        check_out_date: Date.new(2018, 6, 9)
      }
    end

    it 'adds a reservation to the array of all reservations' do
      @hotel.reserve_room(@input)
      expect(@hotel.hotel_reservations[0].name).must_equal "Dr. Frankenstein"
    end
  end

  describe 'list_reservations method' do
    before do
      @hotel = Booking_Manager.new
      @date = Date.new(2018, 6, 8)
      @input1 = { name: "Dr. Frankenstein",
        room_number: 6,
        check_in_date: Date.new(2018, 6, 6),
        check_out_date: Date.new(2018, 6, 9)
      }
      @input2 = { name: "Mx. Mummy",
        room_number: 3,
        check_in_date: Date.new(2018, 6, 6),
        check_out_date: Date.new(2018, 6, 12)
      }
      @hotel.reserve_room(@input1)
      @hotel.reserve_room(@input2)
      @names = ["Dr. Frankenstein", "Mx. Mummy"]
    end

    it 'returns an array of all reservations for that date' do

      expect(@hotel.list_reservations(@date)).must_be_kind_of Array

      @hotel.list_reservations(@date).each do |reservation|
        expect(@names.include?(reservation.name)).must_equal true
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

  describe 'connect_reservation_to_room' do

    it 'finds the room being reserved and adds the reservation to its list of reservations' do
      @hotel = Booking_Manager.new
      @input = { name: "Mx Thing",
        room_number: 1,
        check_in_date: Date.new(2020,9,9),
        check_out_date: Date.new(2020,9,13),
      }
      @hotel.reserve_room(@input)
      expect(@hotel.rooms[0].reservations[0].name).must_equal "Mx Thing"

    end
  end

  describe 'search_room_availability' do

    it 'finds the room being reserved and adds the reservation to its list of reservations' do
      # @hotel = Booking_Manager.new
      # @input = { name: "Mx Thing",
      #   room_number: 1,
      #   check_in_date: Date.new(2020,9,9),
      #   check_out_date: Date.new(2020,9,13),
      # }
      # @hotel.reserve_room(@input)
      # expect(@hotel.rooms[0].reservations[0].name).must_equal "Mx Thing"
    end
  end

  describe 'sort_reservations' do

    it 'finds the room being reserved and adds the reservation to its list of reservations' do
      @hotel = Booking_Manager.new
      @input = { name: "Mx Thing",
        room_number: 1,
        check_in_date: Date.new(2020,9,9),
        check_out_date: Date.new(2020,9,13),
      }
      @hotel.reserve_room(@input)
      @input2 = { name: "Teen Wolf",
        room_number: 1,
        check_in_date: Date.new(2016,7,9),
        check_out_date: Date.new(2016,7,13),
      }
      @hotel.reserve_room(@input2)
      expect(@hotel.hotel_reservations[0].name).must_equal "Teen Wolf"
    end
  end




end
