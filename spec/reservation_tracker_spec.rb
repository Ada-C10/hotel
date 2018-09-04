require_relative 'spec_helper'

describe 'reservation_tracker class' do

  before do
    @hotel = Hotel::ReservationTracker.new
  end

  describe 'intitializing reservation tracker' do
    it 'returns a reservation_tracker class object' do
      expect( @hotel ).must_be_instance_of(Hotel::ReservationTracker)
    end
  end

  describe 'add_reservation method' do
    it 'successfully adds a reservation' do

      reservation = Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,8))
      expect( @hotel.add_reservation(reservation))
    end

    it 'raises argument error if input is not reservation object' do

      expect{
        @hotel.add_reservation('Reservation')
      }.must_raise(ArgumentError)
      expect{
        @hotel.add_reservation(['R','E','S'])
      }.must_raise(ArgumentError)

    end
  end
end
