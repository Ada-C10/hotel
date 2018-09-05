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

  describe 'list_rooms method' do
    it 'successfully returns list of all 20 rooms' do
      expect( @hotel.list_rooms ).must_equal([*1..20])
    end
  end

  describe 'reservations_during_date method' do
    before do
      @hotel.add_reservation(Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,8)))
      @hotel.add_reservation(Hotel::Reservation.new(1, Date.new(2018,8,4), Date.new(2018,8,5)))
      @hotel.add_reservation(Hotel::Reservation.new(2, Date.new(2018,6,4), Date.new(2018,7,7)))

      @list_of_reservations = @hotel.reservations_during_date(Date.new(2018,7,5))
    end

    it 'returns nil if no reservations during date' do
      expect( @hotel.reservations_during_date(Date.new(2017,1,1)) ).must_be_nil
    end

    it 'returns array of reservations' do

      expect( @list_of_reservations ).must_be_instance_of(Array)

      @list_of_reservations.each do |reservation|
        expect( reservation ).must_be_instance_of(Hotel::Reservation)
      end
    end

    it 'returns correct number of reservations' do
      expect( @list_of_reservations.length ).must_equal(2)
    end

  end

  describe 'available_rooms method' do

    it 'returns empty array if no rooms available' do

      [*1..20].each do |room|
        @hotel.add_reservation(Hotel::Reservation.new(room, Date.new(2018,6,4), Date.new(2018,7,7)))
      end

      expect(
        @hotel.available_rooms(Date.new(2018,6,4), Date.new(2018,7,7))
      ).must_equal([])
      expect(
        @hotel.available_rooms(Date.new(2018,6,1), Date.new(2018,6,5))
      ).must_equal([])
      expect(
        @hotel.available_rooms(Date.new(2018,7,1), Date.new(2018,7,15))
      ).must_equal([])
    end

    it 'returns list of available rooms' do

      [*1..10].each do |room|
        @hotel.add_reservation(Hotel::Reservation.new(room, Date.new(2018,6,4), Date.new(2018,7,7)))
      end

      expect(
        @hotel.available_rooms(Date.new(2018,6,4), Date.new(2018,7,7))
      ).must_be_instance_of(Array)
      expect(
        @hotel.available_rooms(Date.new(2018,7,6), Date.new(2018,7,7))
      ).must_equal([*11..20])


      [*11..19].each do |room|
        @hotel.add_reservation(Hotel::Reservation.new(room, Date.new(2018,6,4), Date.new(2018,7,7)))
      end

      expect(
        @hotel.available_rooms(Date.new(2018,6,10), Date.new(2018,7,7))
      ).must_equal([20])
    end
  end

  describe 'book_reservation' do
    before do
      @hotel.add_reservation(Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,8)))
      @hotel.add_reservation(Hotel::Reservation.new(1, Date.new(2018,8,4), Date.new(2018,8,5)))
      @hotel.add_reservation(Hotel::Reservation.new(2, Date.new(2018,6,4), Date.new(2018,7,7)))
    end

    it 'raises error if date is not in correct format' do
      expect{
        @hotel.book_reservation(1, '20180503', Date.new(2018,5,9))
      }.must_raise(ArgumentError)
      expect{
        @hotel.book_reservation(1, Date.new(2018,5,9), '20180503')
      }.must_raise(ArgumentError)
    end

    it 'raises error if room is unavailable' do
      expect{
        @hotel.book_reservation(1, Date.new(2018,7,7), Date.new(2018,7,10))
      }.must_raise(StandardError)
      expect{
        @hotel.book_reservation(2, Date.new(2018,5,1), Date.new(2018,6,4))
      }.must_raise(StandardError)
    end

    it 'successful book returns reservation with matching dates' do
      reservation = @hotel.book_reservation(5, Date.new(2018,7,7), Date.new(2018,7,10))

      expect( reservation ).must_be_instance_of(Hotel::Reservation)
      expect( reservation.start_date ).must_equal(Date.new(2018,7,7))
      expect( reservation.end_date ).must_equal(Date.new(2018,7,10))

    end

    it 'successful book increases total reservations array by one' do
      initial_reservations = @hotel.reservations.length
      reservation = @hotel.book_reservation(5, Date.new(2018,7,7), Date.new(2018,7,10))

      expect( @hotel.reservations.length - initial_reservations).must_equal(1)
    end
  end
end
