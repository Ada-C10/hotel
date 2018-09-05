require_relative 'spec_helper'

describe 'ReservationManager class' do

  let (:reservation) {
    start_date = Date.today + 1
    end_date = start_date + 2
    Hotel::Reservation.new(start_date, end_date, 1)
  }

  let (:reservation_manager) {
    Hotel::ReservationManager.new
  }

  describe 'ReservationManager instantiation' do
    it 'creates an instance of ReservationManager class' do
      expect(reservation_manager).must_be_instance_of Hotel::ReservationManager
    end

    it 'creates an instance of ReservationManager class with reservations as input'do
      expect(Hotel::ReservationManager.new(all_reservations: reservation)).must_be_instance_of Hotel::ReservationManager
    end
  end

  describe 'list_all_rooms function' do
    it 'returns a formatted string of all the rooms' do
      expect(reservation_manager.list_all_rooms).must_be_instance_of String
    end
  end
end
