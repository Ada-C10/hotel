require_relative 'spec_helper'

describe 'Room class' do
  describe 'Room instantiation' do
    let (:reservations) {
      check_in = Date.today + 1
      check_out = check_in + 3
      reservation_1 = Hotel::Reservation.new(check_in, check_out, 1)

      check_in = Date.today + 2
      check_out = check_in + 5
      reservation_2 = Hotel::Reservation.new(check_in, check_out, 2)

      [reservation_1, reservation_2]
    }

    it 'creates an instance of room' do
      expect(Hotel::Room.new(1)).must_be_instance_of Hotel::Room
    end

    it 'raises an ArgumentError if given an invalid room number' do
      expect{Hotel::Room.new(21)}.must_raise ArgumentError
    end

    it 'creates an instance of Room class with reservations as input' do
      room = Hotel::Room.new(1, room_reservations: reservations)
      expect(room).must_be_instance_of Hotel::Room
      expect(room.room_reservations).must_equal reservations
    end
  end
  
end
