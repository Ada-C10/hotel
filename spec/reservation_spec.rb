require_relative 'spec_helper'

describe 'reservation class' do
  before do
    @range = Hotel::DateRange.new(Date.new(2018,7,4), Date.new(2018,7,8))
  end

  describe 'initializing a reservation' do

    it 'returns reservation object given correct inputs' do

      expect(
        Hotel::Reservation.new(1, @range)
      ).must_be_instance_of(Hotel::Reservation)
    end

    it 'raise argument error given wrong input format' do

      expect{
        Hotel::Reservation.new('1', @range)
      }.must_raise(ArgumentError)
      expect{
        Hotel::Reservation.new(1, '20180503')
      }.must_raise(ArgumentError)
      expect{
        Hotel::Reservation.new(1, Date.new(2018,7,4), 300)
      }.must_raise(ArgumentError)
      expect{
        Hotel::Reservation.new(1, @range , 0)
      }.must_raise(ArgumentError)
    end
  end

  describe 'total_cost' do
    it 'returns correct total cost of reservation' do

      expect(
        Hotel::Reservation.new(1, @range).total_cost
      ).must_equal(800)
    end
  end
end
