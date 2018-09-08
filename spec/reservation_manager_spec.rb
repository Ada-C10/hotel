require_relative 'spec_helper'
require 'pry'

describe 'ReservationManager' do
  let(:manager){ Hotel::ReservationManager.new }


  describe 'initialize' do

    it 'is set up for specific instance variables and data types' do

      expect(manager.reservations).must_be_kind_of Array
      expect(manager.rooms).must_be_kind_of Array
      expect(manager.room_cost).must_be_kind_of Numeric
      # expect(manager.room_block_cost).must_be_kind_of Numeric
    end

    it 'will populate 20 instances of room upon initialization' do

      expect(manager.rooms[0]).must_be_instance_of Hotel::Room
      expect(manager.rooms[19]).must_be_instance_of Hotel::Room
      expect(manager.rooms[20]).must_equal nil
    end

    it 'will throw an error if you try to generate more than  20 rooms' do
      expect{
        rooms = []
        21.times do
          room = Hotel::Room.new
          rooms << room
        end
      }.must_raise StandardError
    end
  end

  let(:find_first_room) {
    date_range = (Date.parse("10/10/2018")..Date.parse("14/10/2018")).to_a
    manager.find_available_room(date_range)
  }

  let(:find_two_rooms) {
    date_range = (Date.parse("10/09/2018")..Date.parse("14/09/2018")).to_a
    rooms = []
    2.times do
      room = manager.find_available_room(date_range)
      rooms << room
    end
    rooms
  }

  describe 'find_available_room' do
    it 'will return the first available room for reservation that date range' do
      expect(find_first_room).must_be_instance_of Hotel::Room
      expect(find_first_room.room_number).must_equal 1
    end

    it 'will return the first available room for 2 reservations in same date range' do
      expect(find_two_rooms.length).must_equal 2
      expect(find_two_rooms[0]).must_be_instance_of Hotel::Room
      expect(find_two_rooms[1]).must_be_instance_of Hotel::Room
      expect(find_two_rooms[0].room_number).must_equal 1
      expect(find_two_rooms[1].room_number).must_equal 1
    end

    it 'will throw an error if no available rooms' do
      expect{
        date_range = (Date.parse("10/08/2018")..Date.parse("14/08/2018")).to_a
        21.times do
          room = manager.find_available_room(date_range)
          rooms << room
        end
        rooms
      }.must_raise StandardError
    end
  end

  let(:valid_total_cost) {
    #4nights
    manager = Hotel::ReservationManager.new
    manager.calculate_total_cost("12/09/2018", "16/09/2018", 200)
  }

  describe 'calculate_total_cost' do

    it 'will calculate total cost given valid room_cost and checkin/checkout' do
      expect(valid_total_cost).must_equal 4 * 200
    end

    it 'will throw error if total cost is 0 or less' do
      expect{
        manager = Hotel::ReservationManager.new
        manager.calculate_total_cost("12/09/2018", "16/09/2018", 0)
      }.must_raise ArgumentError
    end

    it 'will throw error if total cost is negative' do
      expect{
        manager = Hotel::ReservationManager.new
        manager.calculate_total_cost("12/09/2018", "16/09/2018", -200)
      }.must_raise ArgumentError
    end
  end

  let(:valid_add_to_list) {
    input = { checkin_date: "12/09/2018", checkout_date: "15/09/2018", room_number: 2, total_cost: 600, confirmation_id: "ABC12345" }
    reservation = Hotel::Reservation.new(input)
    manager = Hotel::ReservationManager.new
    manager.add_reservation_to_list(reservation)
    manager.reservations[0]
  }

  let(:no_reservations) {
    manager = Hotel::ReservationManager.new
    manager.reservations
  }

  let(:some_reservations) {
    input = { checkin_date: "12/09/2018", checkout_date: "15/09/2018", room_number: 2, total_cost: 600, confirmation_id: "ABC12345" }
    reservation = Hotel::Reservation.new(input)
    manager = Hotel::ReservationManager.new
    manager.add_reservation_to_list(reservation)
    manager.reservations
  }

  describe 'add_reservation_to_list' do

    it 'will add a reservation to the list of reservations' do
      expect(valid_add_to_list).must_be_instance_of Hotel::Reservation
    end

    it 'will increase the count of reservations by 1' do

      expect(no_reservations.length).must_equal 0
      expect(some_reservations.length).must_equal 1
    end

    it 'will throw an argument error if param is not a valid reservation' do
      expect{
        manager = Hotel::ReservationManager.new
        manager.add_reservation_to_list("reservation, 12/24/2018, 12/24/2018")
      }.must_raise ArgumentError
    end
  end

  describe 'parse_input' do
  end



end
