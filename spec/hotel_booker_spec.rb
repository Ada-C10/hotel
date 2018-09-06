require_relative 'spec_helper'

describe 'HotelBooker class' do

  let (:reservation1) {
    check_in = Date.today + 1
    check_out = check_in + 3
    Hotel::Reservation.new(check_in, check_out, Hotel::Room.new(1))
  }

  let (:reservation2) {
    check_in = Date.today + 2
    check_out = check_in + 5
    Hotel::Reservation.new(check_in, check_out, Hotel::Room.new(2))
  }

  let (:hotel_booker) {
    Hotel::HotelBooker.new(all_reservations: [reservation1, reservation2])
  }
  #
  # let (:empty_hotel_booker) {
  #   Hotel::HotelBooker.new
  # }


  describe 'HotelBooker instantiation' do
    it 'creates an instance of HotelBooker class' do
      expect(Hotel::HotelBooker.new).must_be_instance_of Hotel::HotelBooker
    end

    it 'creates an instance of HotelBooker class with reservations as input'do
      expect(hotel_booker).must_be_instance_of Hotel::HotelBooker
    end

    it 'if reservations passed in, it stores all reservations in an array of Reservations' do
      hotel_booker.all_reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe 'list_all_rooms method' do
    it 'returns a formatted string of all the rooms' do
      expect(hotel_booker.list_all_rooms).must_be_instance_of String
    end
  end

  describe 'reserve_a_room method' do
    it 'returns an instance of reservation' do
      expect(hotel_booker.reserve_a_room(Date.today + 1, Date.today + 4)).must_be_instance_of Hotel::Reservation
    end

    it 'raises an error when given invalid dates' do
      expect{hotel_booker.reserve_a_room(Date.today + 1, Date.today - 4)}.must_raise ArgumentError
    end

    it 'reserves the first available room for the given date range' do
      expect(hotel_booker.reserve_a_room(Date.today + 1, Date.today + 2).room.room_num).must_equal 2
      expect(hotel_booker.reserve_a_room(Date.today + 1, Date.today + 9).room.room_num).must_equal 3
    end
  end

  describe 'get_reservations_by_date method' do
    it 'returns a list of all reservations for a given date ' do
      matched_reservation = hotel_booker.get_reservations_by_date(Date.today + 2)

      matched_reservation.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end

      expect(matched_reservation.length).must_equal 2

      matched_reservation_2 = hotel_booker.get_reservations_by_date(Date.today + 1)

      expect(matched_reservation_2[0].room.room_num).must_equal 1
    end

    it 'returns an empty array if no reservations match a given date' do
      matched_reservation = hotel_booker.get_reservations_by_date(Date.today + 10)
      expect(matched_reservation).must_be_instance_of Array
      expect(matched_reservation.length).must_equal 0
    end
  end

  describe 'list_available_rooms method' do
    it 'returns an array containing a list of available room numbers for a given date' do
      expect(hotel_booker.list_available_rooms(Date.today + 2)).must_be_instance_of Array
    end

    it 'correctly identifies the list of available room numbers for a given date' do
      all_rooms = [*1..20]
      available_rooms = [*3..20]

      expect(hotel_booker.list_available_rooms(Date.today + 2)).must_equal available_rooms

      expect(hotel_booker.list_available_rooms(Date.today + 7)).must_equal all_rooms
    end

    it 'raises an error if given an invalid date' do
      expect{hotel_booker.list_available_rooms("Not a Date")}.must_raise ArgumentError
    end

  end
end
