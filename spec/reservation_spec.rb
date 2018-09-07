require_relative 'spec_helper'

describe 'reservation class' do
  describe 'initializing a reservation' do

    it 'returns reservation object given correct inputs' do

      expect( Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,8))
      ).must_be_instance_of(Hotel::Reservation)
      expect( Hotel::Reservation.new(10, Date.new(2018,6,4), Date.new(2018,7,4), 201)
      ).must_be_instance_of(Hotel::Reservation)
    end

    it 'raise argument error given wrong input format' do

      expect{
        Hotel::Reservation.new('1', Date.new(2018,7,4), Date.new(2018,7,8))
      }.must_raise(ArgumentError)
      expect{
        Hotel::Reservation.new(1, '20180503', Date.new(2018,7,8))
      }.must_raise(ArgumentError)
      expect{
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,8), 'RATE')
      }.must_raise(ArgumentError)
      expect{
        Hotel::Reservation.new([], Date.new(2018,7,4), Date.new(2018,7,8) , 300)
      }.must_raise(ArgumentError)
    end

    it 'raise standard error if start date is after end date' do

      expect{
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,1))
      }.must_raise(StandardError)
    end

    it 'raise standard error if start date is same as end date' do

      expect{
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,4))
      }.must_raise(StandardError)
    end
  end

  describe 'total_nights' do
    it 'returns correct number of days stayed' do

      expect(
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,5)).total_nights
      ).must_equal(1)
      expect(
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,10)).total_nights
      ).must_equal(6)
    end
  end

  describe 'total_cost' do
    it 'returns correct total cost of reservation' do

      expect(
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,5)).total_cost
      ).must_equal(200)
      expect(
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,10), 305).total_cost
      ).must_equal(1830)
    end
  end

  describe 'checking dates within reservation' do
    before do
      @reservation = Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,10))
    end

    describe 'date_within_reservation?' do

      it 'raise argumenterror for nondate inputs' do
        expect{
          @reservation.date_within_reservation?('datestring')
        }.must_raise(ArgumentError)
        expect{
          @reservation.date_within_reservation?(23)
        }.must_raise(ArgumentError)
        expect{
          @reservation.date_within_reservation?([])
        }.must_raise(ArgumentError)
      end

      it 'returns false for dates out of range' do
        expect(
          @reservation.date_within_reservation?(Date.new(2018,5,1))
        ).must_equal(false)
        expect(
          @reservation.date_within_reservation?(Date.new(2018,7,10))
        ).must_equal(false)
      end

      it 'returns true for dates in range' do
        expect(
          @reservation.date_within_reservation?(Date.new(2018,7,4))
        ).must_equal(true)
        expect(
          @reservation.date_within_reservation?(Date.new(2018,7,9))
        ).must_equal(true)
      end
    end


    describe 'daterange_within_reservation' do

      it 'returns false for dates completely out of range' do
        expect(
          @reservation.daterange_within_reservation?(Date.new(2018,5,3), Date.new(2018,6,3))
        ).must_equal(false)
        expect(
          @reservation.daterange_within_reservation?(Date.new(2018,7,10), Date.new(2018,8,1))
        ).must_equal(false)
      end

      it 'returns true for dates within reservation' do
        expect(
          @reservation.daterange_within_reservation?(Date.new(2018,7,5), Date.new(2018,7,6))
        ).must_equal(true)
        expect(
          @reservation.daterange_within_reservation?(Date.new(2018,6,5), Date.new(2018,7,6))
        ).must_equal(true)
        expect(
          @reservation.daterange_within_reservation?(Date.new(2018,7,9), Date.new(2018,7,15))
        ).must_equal(true)
      end
    end
  end
end
