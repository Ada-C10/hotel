require_relative 'spec_helper'

describe 'Room class' do

  let (:reservations) {
    check_in = Date.today + 1
    check_out = check_in + 3
    reservation_1 = Hotel::Reservation.new(check_in, check_out, 1)

    check_in = Date.today + 2
    check_out = check_in + 5
    reservation_2 = Hotel::Reservation.new(check_in, check_out, 2)

    [reservation_1, reservation_2]
  }

  describe 'Room instantiation' do

    it 'creates an instance of room' do
      expect(Hotel::Room.new(1)).must_be_instance_of Hotel::Room
    end

    it 'raises an ArgumentError if given an invalid room number' do
      expect{Hotel::Room.new(21)}.must_raise ArgumentError
      expect{
        Hotel::Reservation.new(check_in, check_out, 'Not a number')
      }.must_raise ArgumentError

      expect{
        Hotel::Reservation.new(check_in, check_out, nil)
      }.must_raise ArgumentError

      expect{
        Hotel::Reservation.new(check_in, check_out, " ")
      }.must_raise ArgumentError
    end

    it 'creates an instance of Room class with reservations as input' do
      room = Hotel::Room.new(1, room_reservations: reservations)
      expect(room).must_be_instance_of Hotel::Room
      expect(room.room_reservations).must_equal reservations
    end
  end

  describe 'get_reservations_by_date method' do
    it 'returns an array of reservations on this room for the given date' do
      room = Hotel::Room.new(1, room_reservations: reservations)
      expect(room.get_reservations_by_date(Date.today + 2)).must_equal reservations
      expect(room.get_reservations_by_date(Date.today + 1)).must_equal [reservations[0]]
    end
  end
end
