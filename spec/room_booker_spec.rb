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
      @array_of_rooms = @hotel.list_available_rooms(
        Date.new(2018, 4, 1), Date.new(2018, 4, 4)
      )
    end

    it 'returns an array of rooms' do
      expect(@array_of_rooms).must_be_kind_of Array
      @array_of_rooms.each do |room|
        expect(room).must_be_kind_of Struct
        expect(1..20).must_include room.id
        expect(room.cost).must_equal 200
      end
    end

    it 'only returns available rooms' do
      room2 = @hotel.rooms.find { |room| room.id == 2 }
      room14 = @hotel.rooms.find { |room| room.id == 14 }
      room15 = @hotel.rooms.find { |room| room.id == 15 }
      remaining_rooms = @hotel.rooms.find_all { |room| room.id != 14 && room.id != 2 && room.id != 15 }

      expect(@array_of_rooms).wont_include room2
      expect(@array_of_rooms).wont_include room14
      expect(@array_of_rooms).wont_include room15

      remaining_rooms.each do |room|
        expect(@array_of_rooms).must_include room
      end
    end

    it 'does not include blocked rooms' do
      block = @hotel.new_room_block("fdsaj", Date.new(2018, 4, 1), Date.new(2018, 4, 6), 5, 150)

      block.rooms.each do |room|
        expect(@array_of_rooms).wont_include room
      end
    end
  end

  describe 'new_reservation method' do
    before do
      @hotel = BookingLogic::RoomBooker.new

      room_id1 = 1
      check_in1 = Date.new(2018, 4, 1)
      check_out1 = Date.new(2018, 4, 2)
      @reservation1 = @hotel.new_reservation(room_id1, check_in1, check_out1)

      room_id2 = 2
      check_in2 = Date.new(2018, 4, 3)
      check_out2 = Date.new(2018, 4, 6)
      @reservation2 = @hotel.new_reservation(room_id2, check_in2, check_out2)

      room_id3 = 3
      check_in3 = Date.new(2018, 3, 21)
      check_out3 = Date.new(2018, 4, 3)
      @reservation3 = @hotel.new_reservation(room_id3, check_in3, check_out3)
    end

    it 'instantiates a new Reservation and adds it to master collection' do
      expect(@reservation1).must_be_instance_of BookingLogic::Reservation
      expect(@hotel.reservations).must_include @reservation1
    end

    it 'throws a StandardError when provided with invalid date range' do
      expect{ @hotel.new_reservation(4, Date.new(2018, 4, 1), Date.new(2015, 5, 1)) }.must_raise StandardError
    end

    it 'throws a RoomNotAvailable error when trying to reserve a room with a pre-existing reservation conflicting with given dates' do
      expect{ @hotel.new_reservation(3, Date.new(2018, 4, 1), Date.new(2018, 4, 4)) }.must_raise RoomNotAvailable
    end

    it 'throws a RoomNotAvailable error when all rooms in the hotel are booked' do
      20.times do |i|
        @hotel.new_reservation((i + 1), Date.new(2019, 5, 1), Date.new(2019, 5, 4))
      end

      expect{ @hotel.new_reservation(14, Date.new(2019, 5, 1), Date.new(2019, 5, 4)) }.must_raise RoomNotAvailable
    end
  end
end

describe 'Wave 3' do
  before do
    @hotel = BookingLogic::RoomBooker.new

    room_id1 = 14
    @check_in1 = Date.new(2018, 4, 1)
    check_out1 = Date.new(2018, 4, 2)
    @reservation1 = @hotel.new_reservation(room_id1, @check_in1, check_out1)

    room_id2 = 15
    check_in2 = Date.new(2018, 4, 3)
    @check_out2 = Date.new(2018, 4, 6)
    @reservation2 = @hotel.new_reservation(room_id2, check_in2, @check_out2)

    @name = "Gay Convention"
    @room_rate = 160
    @number_of_rooms = 5
    @room_block = @hotel.new_room_block(@name, @check_in1, @check_out2, @number_of_rooms, @room_rate)
  end

  describe 'new_room_block method' do
    it 'instantiates a new RoomBlock' do
      expect(@room_block).must_be_instance_of BookingLogic::RoomBlock

      # The following assertions based off of provided arguments in before block
      expect(@room_block.name).must_equal @name
      expect(@room_block.check_in).must_equal @check_in1
      expect(@room_block.check_out).must_equal @check_out2
      expect(@room_block.rooms.length).must_equal @number_of_rooms
      expect(@room_block.rate).must_equal @room_rate
    end

    it 'throws an error when creating a RoomBlock with more than 5 rooms' do
      expect{ @hotel.new_room_block(@name, @check_in1, @check_out2, 6, @room_rate) }.must_raise StandardError
    end

    it 'throws an error when there are not enough rooms left to create new RoomBlock' do
      2.times do |i|
        @hotel.new_room_block("#{i}", @check_in1, @check_out2, 5, 150)
      end

      expect{ @hotel.new_room_block("asldkfj", @check_in1, @check_out2, 5, 150) }.must_raise StandardError
    end
  end

  describe 'new_block_reservation method' do
    it 'instantiates a new Reservation and adds it to master collection' do
      reservation = @hotel.new_block_reservation(@name)

      expect(reservation).must_be_instance_of BookingLogic::Reservation
      expect(@hotel.reservations).must_include reservation
    end

    it 'throws a NoRoomsInBlock error when all rooms in that block have already been reserved' do
      5.times do
        @hotel.new_block_reservation(@name)
      end

      expect{ @hotel.new_block_reservation(@name) }.must_raise NoRoomsInBlock
    end
  end
end
