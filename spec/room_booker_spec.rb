require_relative 'spec_helper.rb'
require 'pry'

describe 'Wave 1' do
  before do
    @hotel = BookingLogic::RoomBooker.new

    room_id1 = 14
    check_in1 = Date.new(2018, 4, 1)
    check_out1 = Date.new(2018, 4, 2)
    @reservation1 = @hotel.new_reservation(room_id1, check_in1, check_out1)

    room_id2 = 15
    check_in2 = Date.new(2018, 4, 3)
    check_out2 = Date.new(2018, 4, 6)
    @reservation2 = @hotel.new_reservation(room_id2, check_in2, check_out2)
  end

  describe 'list_rooms method' do
    it 'lists all rooms in the hotel' do
      expect(@hotel.list_rooms).must_be_kind_of Array
      expect(@hotel.list_rooms.length).must_equal 20
    end
  end

  describe 'new_reservation method' do
    it 'adds a new reservation to master collection' do
      expect(@hotel.reservations.first).must_be_instance_of BookingLogic::Reservation
    end
  end

  describe 'list_reservations method' do
    it 'lists the reservations for a given date' do
      given_date = Date.new(2018, 4, 1)
      listed_reservations = @hotel.list_reservations(given_date)

      expect(listed_reservations).must_be_kind_of Array
      # According to the before block there should only be one reservation on 4/1/2018
      expect(listed_reservations.length).must_equal 1
      listed_reservations.each do |reservation|
        expect(reservation).must_be_instance_of BookingLogic::Reservation
      end
    end
  end

  describe 'reservation_cost method' do
    it 'finds the cost of a given reservation' do
      reservation = @hotel.reservation_cost(14, Date.new(2018, 4, 1))
      reservation2 = @hotel.reservation_cost(15, Date.new(2018, 4, 3))

      expect(reservation).must_equal 200
      expect(reservation2).must_equal 600
    end
  end
end

describe 'Wave 2' do
  before do
    @hotel = BookingLogic::RoomBooker.new

    room_id1 = 14
    check_in1 = Date.new(2018, 4, 1)
    check_out1 = Date.new(2018, 4, 2)
    @reservation1 = @hotel.new_reservation(room_id1, check_in1, check_out1)

    room_id2 = 15
    check_in2 = Date.new(2018, 4, 3)
    check_out2 = Date.new(2018, 4, 6)
    @reservation2 = @hotel.new_reservation(room_id2, check_in2, check_out2)

    room_id3 = 2
    check_in3 = Date.new(2018, 3, 21)
    check_out3 = Date.new(2018, 4, 3)
    @reservation3 = @hotel.new_reservation(room_id3, check_in3, check_out3)
  end

  describe 'list_available_rooms method' do
    before do
      @array_of_rooms = @hotel.list_available_rooms(Date.new(2018, 4, 1))
    end

    it 'returns an array of rooms' do
      expect(@array_of_rooms).must_be_kind_of Array
      @array_of_rooms.each do |room|
        expect(room).must_be_kind_of Struct
      end
    end

    it 'only returns available rooms' do
      room14 = @hotel.rooms.find { |room| room.id == 14 }
      room2 = @hotel.rooms.find { |room| room.id == 2 }
      remaining_rooms = @hotel.rooms.find_all { |room| room.id != 14 && room.id != 2 }

      expect(@array_of_rooms).wont_include room14
      expect(@array_of_rooms).wont_include room2
      remaining_rooms.each do |room|
        expect(@array_of_rooms).must_include room
      end
    end
  end
end
