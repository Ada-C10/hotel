require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Booking Manager class" do

  describe 'Hotel Manager instantiation' do
    before do
      @hotel = Hotel::Booking_Manager.new
    end

    it 'has an array of all rooms in hotel' do
      expect(@hotel.rooms).must_be_kind_of Array
    end

    it 'has 20 rooms in the hotel' do
      expect(@hotel.rooms.length).must_equal 20
    end

    it 'each index of the array is an instance of class' do
      expect(@hotel.rooms[0]).must_be_kind_of Hotel::Room
    end
  end

  describe 'get_room method' do
    before do
      @hotel = Hotel::Booking_Manager.new
    end

    it 'returns an Array of rooms in hotel' do
      expect(@hotel.get_rooms).must_be_kind_of Array
    end

    it 'returns an Array of correct length' do
        expect(@hotel.get_rooms.length).must_equal 20
    end
  end

  describe 'reserve_room method' do
    before do
      @hotel = Hotel::Booking_Manager.new
      @date1 = Date.new(2018, 6, 6)
      @date2 = Date.new(2018, 6, 9)
      @all_rooms_available = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @input = { name: "Dr. Frankenstein",
        room_number: 6,
        check_in_date: @date1,
        check_out_date: @date2
      }
    end

    it 'adds a reservation to the array of all reservations' do
      @hotel.reserve_room(@input)
      expect(@hotel.hotel_reservations[0].name).must_equal "Dr. Frankenstein"
    end

    it 'checks against room availbility and returns an Argument error if the date range is filled.' do
      @all_rooms_available.each do |i|
        @input2 = { name: "Señor Dracula",
          room_number: i,
          check_in_date: @date1,
          check_out_date: @date2,
        }
        @hotel.reserve_room(@input2)
      end
      expect{@hotel.reserve_room(@input)}.must_raise ArgumentError
    end
  end

  describe 'list_reservations method' do
    before do
      @hotel = Hotel::Booking_Manager.new
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
      @names = ["Dr. Frankenstein", "Mx. Mummy"]
    end

    it 'returns an array of all reservations for that date' do
      @hotel.reserve_room(@input1)
      @hotel.reserve_room(@input2)
      expect(@hotel.list_reservations(@date)).must_be_kind_of Array
      @list = @hotel.list_reservations(@date)
      @list.each do |reservation|
          expect(@names.include?(reservation.name)).must_equal true
      end
    end
    it 'returns an error if no rooms booked on given date' do
      expect{ @hotel.list_reservations(@date) }.must_raise StandardError
    end
  end
  
  describe 'total_cost_of_stay method' do
    before do
      @date = Date.new(2018, 6, 6)
      @date2 = Date.new(2018, 6, 9)
      @hotel = Hotel::Booking_Manager.new
      @input = { name:"Dr. Frankenstein",
        room_number: 6,
        check_in_date: @date,
        check_out_date: @date2
      }
      @reservation = Hotel::Reservation.new(@input)
      @input2 = {
        check_in_date: @date,
        check_out_date: @date2,
        block_name: "Munster - Addams Wedding",
        block_discount: 0.05,
        number_of_rooms_to_block: 3
      }
      @block_room = Hotel::Block_Room.new(@input2)
    end

    it 'correctly sums the cost of a stay at the hotel and returns a float' do
      expect(@hotel.total_cost_of_stay(@reservation)).must_equal 600.0
      expect(@hotel.total_cost_of_stay(@reservation)).must_be_kind_of Float
    end

    it 'correctly sums the cost of a block room reservation' do
      expect(@hotel.total_cost_of_stay(@block_room)).must_equal 570.0
    end
  end

  describe 'search_all_rooms_availability' do

    before do
      @hotel = Hotel::Booking_Manager.new
        #TEST RANGE
      @date1 = Date.new(2020,9,9)
      @date2 = Date.new(2020,9,13)
        #INSIDE TEST RANGE
      @date3 = Date.new(2020,9,10)
      @date4 = Date.new(2020,9,12)
        #OUTSIDE TEST RANGE
      @date5 = Date.new(2020,9,4)
      @date6 = Date.new(2020,9,16)

      @input = { name: "Mx Thing",
        room_number: 1,
        check_in_date: @date1,
        check_out_date: @date2,
      }
      @input2 = { name: "Teen Wolf",
        room_number: 2,
        check_in_date: @date1,
        check_out_date: @date2,
      }
      @input3 = { name: "Señor Dracula",
        room_number: 3,
        check_in_date: @date1,
        check_out_date: @date2,
      }
      @hotel.reserve_room(@input2)
      @hotel.reserve_room(@input3)
      @hotel.reserve_room(@input)
      @available_rooms = [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @all_rooms_available = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    end

    it 'given a range of dates, it returns a list of available rooms, if the reservation shares the same dates as a reserved room' do
      expect(@hotel.search_all_rooms_availability(@date1, @date2)).must_equal @available_rooms
    end

    it 'it returns a list of available rooms, leaving rooms out if the reservation check in date is in the middle dates of a reserved room'do
      expect(expect(@hotel.search_all_rooms_availability(@date3, @date4)).must_equal @available_rooms)
    end
    it 'it returns a list of available rooms, leaving rooms out if the reservation check in date is in the middle dates of a reserved room'do
      expect(expect(@hotel.search_all_rooms_availability(@date3, @date6)).must_equal @available_rooms)
    end
    it 'it returns a list of available rooms, leaving rooms out if the check out date is in the middle dates of a reserved room'do
      expect(expect(@hotel.search_all_rooms_availability(@date5, @date4)).must_equal @available_rooms)
    end
    it 'it returns a list of available rooms, leaving rooms out if the reservation check in date and check out date is in the middle dates of a reserved room'do
      expect(expect(@hotel.search_all_rooms_availability(@date3, @date4)).must_equal @available_rooms)
    end
    it 'it returns a list of available rooms, leaving rooms out if the reservation check in date is in the middle dates of a reserved room'do
      expect(expect(@hotel.search_all_rooms_availability(@date3, @date6)).must_equal @available_rooms)
    end
    it 'it returns a list of available rooms, leaving rooms out if the dates of a reserved room fall within a proposed check in date or check out date'do
      expect(expect(@hotel.search_all_rooms_availability(@date5, @date6)).must_equal @available_rooms)
    end
    it 'it returns a list of available rooms, returning rooms where the  reservation check in date is on the check out day of another reservation'do
      expect(expect(@hotel.search_all_rooms_availability(@date2, @date6)).must_equal @all_rooms_available)
    end
    it 'it returns a list of available rooms, returning rooms where the  reservation check out date is on the check in day of another reservation'do
      expect(expect(@hotel.search_all_rooms_availability(@date5, @date1)).must_equal @all_rooms_available)
    end

    it 'returns an Argument Error if no rooms are vacant'do
      @available_rooms.each do |i|
      @input4 = { name: "Señor Dracula",
        room_number: i,
        check_in_date: @date1,
        check_out_date: @date2,
      }
      @hotel.reserve_room(@input4)
      end
      expect{@hotel.search_all_rooms_availability(@date1, @date2)}.must_raise Exception
    end
  end

  describe 'create_block method' do
    before do
      @hotel = Hotel::Booking_Manager.new
      @date = Date.new(2028,8,8)
      @date2 = Date.new(2028,8,11)
      @input = {
        check_in_date: @date,
        check_out_date: @date2,
        block_name: "Munster - Addams Wedding",
        block_discount: 0.08,
        number_of_rooms_to_block: 3
      }
      @input2 = {
        check_in_date: @date,
        check_out_date: @date2,
        block_name: "Munster - Addams Wedding",
        block_discount: 0.08,
        number_of_rooms_to_block: 5
      }
      @input3 = {
        check_in_date: @date,
        check_out_date: @date2,
        block_name: "Munster - Addams Wedding",
        block_discount: 0.08,
        number_of_rooms_to_block: 6
      }
    end

    it 'creates an array of block room reservations and adds it an array of all block room reservations ' do
      @block = @hotel.create_block(@input)
      expect(@hotel.block_reservations.length).must_equal 1
      @hotel.block_reservations[0].each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Block_Room
        expect(reservation.block_name).must_equal "Munster - Addams Wedding"
        expect(reservation.check_in_date).must_equal @date
        expect(reservation.nights_of_stay.length).must_equal 3
      end
    end

    it 'raises an Exception if you try to create a block of the same dates' do
      @hotel.create_block(@input2)
      @hotel.create_block(@input2)
      @hotel.create_block(@input2)
      @hotel.create_block(@input2)
      expect{@hotel.create_block(@input2)}.must_raise ArgumentError
    end

    it 'raises an Exception if you try to create a block of more than 5 rooms' do
      expect{@hotel.create_block(@input3)}.must_raise ArgumentError
    end

  end

  describe 'check_block_status method' do
    before do
      @hotel = Hotel::Booking_Manager.new
      @date = Date.new(2028,8,8)
      @date2 = Date.new(2028,8,11)
      @input = {
        check_in_date: @date,
        check_out_date: @date2,
        block_name: "Munster - Addams Wedding",
        block_discount: 0.08,
        number_of_rooms_to_block: 3
      }
      @input2 = "Munster - Addams Wedding"
      @input3 = {block_name: "Munster - Addams Wedding", name: "Cousin IT"}
      @block = @hotel.create_block(@input)
    end

    it 'takes a name of a block and returns an array of rooms in that block have that have a status of :AVAILABLE' do
      @check = @hotel.check_block_status(@input2)
      expect(@check).must_be_kind_of Array
      expect(@check.length).must_equal 3
      expect(@check.first.block_reservation_status).must_equal :AVAILABLE
    end

    it 'returns a smaller array if one of the block rooms gets booked' do
      @hotel.reserve_room_in_block(@input3)
      @check2 = @hotel.check_block_status(@input2)
      expect(@check2.length).must_equal 2
    end

    it 'returns an error if all rooms in block booked' do
      @hotel.reserve_room_in_block(@input3)
      @hotel.reserve_room_in_block(@input3)
      @hotel.reserve_room_in_block(@input3)
      expect{ @hotel.check_block_status(@input2) }.must_raise StandardError
    end

  end

  describe 'reserve_room_in_block method' do
    before do
      @hotel = Hotel::Booking_Manager.new
      @date = Date.new(2028,8,8)
      @date2 = Date.new(2028,8,11)
      @input = {
        check_in_date: @date,
        check_out_date: @date2,
        block_name: "Munster - Addams Wedding",
        block_discount: 0.08,
        number_of_rooms_to_block: 3
      }
      @input2 = {block_name: "Munster - Addams Wedding", name: "Cousin IT"}
      @block = @hotel.create_block(@input)
    end

    it 'changes a block room reservation that is :AVAILABLE to :BOOKED' do
      @check_block = @hotel.block_reservations.first
      expect(@check_block.first.block_reservation_status).must_equal :AVAILABLE
      @hotel.reserve_room_in_block(@input2)
      expect(@check_block.first.block_reservation_status).must_equal :BOOKED

    end

    it 'changes the name of the reservation but keeps that name of the block reservation' do
      @check_block = @hotel.block_reservations.first
      @hotel.reserve_room_in_block(@input2)
      expect(@check_block.first.name).must_equal "Cousin IT"
      expect(@check_block.first.block_name).must_equal "Munster - Addams Wedding"
    end
  end
end
