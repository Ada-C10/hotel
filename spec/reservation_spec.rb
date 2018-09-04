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

  describe 'days stayed' do
    it 'returns correct number of days stayed' do

      expect(
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,5)).total_nights
      ).must_equal(1)
      expect(
        Hotel::Reservation.new(1, Date.new(2018,7,4), Date.new(2018,7,10)).total_nights
      ).must_equal(6)
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

  end

end
