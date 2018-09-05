require_relative 'spec_helper'

describe 'ReservationManager class' do

  let (:reservation1) {
    start_date = Date.today + 1
    end_date = start_date + 3
    Hotel::Reservation.new(start_date, end_date, 1)
  }

  let (:reservation2) {
    start_date = Date.today + 2
    end_date = start_date + 5
    Hotel::Reservation.new(start_date, end_date, 2)
  }

  let (:reservation_manager) {
    Hotel::ReservationManager.new(all_reservations: [reservation1, reservation2])
  }

  describe 'ReservationManager instantiation' do
    it 'creates an instance of ReservationManager class' do
      expect(Hotel::ReservationManager.new).must_be_instance_of Hotel::ReservationManager
    end

    it 'creates an instance of ReservationManager class with reservations as input'do
      expect(reservation_manager).must_be_instance_of Hotel::ReservationManager
    end

    it 'if reservations passed in, it stores all reservations in an array of Reservations' do
      reservation_manager.all_reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe 'list_all_rooms method' do
    it 'returns a formatted string of all the rooms' do
      expect(reservation_manager.list_all_rooms).must_be_instance_of String
    end
  end

  describe 'get_reservations_by_date method' do
    it 'returns a list of all reservations for a given date ' do
      matched_reservation = reservation_manager.get_reservations_by_date(Date.today + 2)

      matched_reservation.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
      # binding.pry
      expect(matched_reservation.length).must_equal 2

      matched_reservation_2 = reservation_manager.get_reservations_by_date(Date.today + 1)

      expect(matched_reservation_2[0].room_num).must_equal 1


    end
  end
end
