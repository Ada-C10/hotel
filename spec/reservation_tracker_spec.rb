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
      initial_reservations = @hotel.reservations.length
      @hotel.add_reservation(reservation)
      expect( @hotel.reservations.length - initial_reservations).must_equal(1)
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

  describe 'sortby_startdate method' do
    it 'successfully sorts the reservations array by start_date' do

      @hotel.add_reservation(Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,8)))
      @hotel.add_reservation(Hotel::Reservation.new(1, Date.new(2018,5,4), Date.new(2018,8,5)))
      @hotel.add_reservation(Hotel::Reservation.new(1, Date.new(2018,7,3), Date.new(2018,7,5)))
      @hotel.add_reservation(Hotel::Reservation.new(1, Date.new(2018,6,4), Date.new(2018,6,8)))

      @hotel.sortby_startdate

      (@hotel.reservations.length-1).times do |i|
        expect(
          @hotel.reservations[i].start_date < @hotel.reservations[i+1].start_date
        ).must_equal(true)
      end
    end
  end

  describe 'list_rooms method' do
    it 'successfully returns list of all 20 rooms' do
      expect( @hotel.list_rooms ).must_equal([*1..20])
    end
  end

end
