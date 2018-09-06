require_relative 'spec_helper.rb'

describe 'BookingManager' do
  let (:reservation_manager) {
    BookingManager.new
  }

  let (:check_in1) {
    Date.new(2015, 1, 1)
  }

  let (:check_out1){
    Date.new(2015, 1, 7)
  }
  let (:reservation1) {
    Reservation.new(5, check_in1, check_out1)
  }

  describe '#initialize' do

    it 'Creates an empty Array at start for Reservations to live in' do
      expect(reservation_manager.reservations).must_be_kind_of Array
    end

  end

  # describe '#make_reservation' do
  #   it 'creates a new reservation object and pushes it into the reservations array'
  #   expect(reservation_manager.make_reservation(5, check_in1, checkout1))
  # end

end
