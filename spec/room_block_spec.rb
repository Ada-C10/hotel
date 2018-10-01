require_relative 'spec_helper'

describe 'RoomBlock class' do
  before do
    @range = Hotel::DateRange.new(Date.new(2018,9,5), Date.new(2018,9,17))
  end

  describe 'initializing a roomblock' do

    it 'returns roomblock object given correct inputs' do

      expect( Hotel::RoomBlock.new([*1..5], @range, 100)
    ).must_be_instance_of(Hotel::RoomBlock)

    end

    it 'raise argument error given wrong input format' do

      expect{
        Hotel::RoomBlock.new(2, @range, 100)
      }.must_raise(ArgumentError)
      expect{
        Hotel::RoomBlock.new([2], Date.new(2018,7,8), 100)
      }.must_raise(ArgumentError)
      expect{
        Hotel::RoomBlock.new([2], @range, -3)
      }.must_raise(ArgumentError)
    end

    it 'raise argument error if trying to book more than 5 rooms' do
      expect{
        Hotel::RoomBlock.new([*1..6], @range, 100)
      }.must_raise(ArgumentError)
    end
  end

  describe 'book_reservation' do
    before do
      @roomblock = Hotel::RoomBlock.new([*1..5], @range, 100)
    end

    it 'raises argumenterror for invalid date range' do
      expect{
        @roomblock.book_reservation(5,
          Hotel::DateRange.new(Date.new(2018,9,5), Date.new(2018,9,16)))
      }.must_raise(ArgumentError)
      expect{
        @roomblock.book_reservation(5,
          Hotel::DateRange.new(Date.new(2018,9,6), Date.new(2018,9,17)))
      }.must_raise(ArgumentError)
    end

    it 'raises argumenterror for invalid room number' do
      expect{
        @roomblock.book_reservation(9, @range)
      }.must_raise(ArgumentError)

    end

    it 'returns reservation object with correct room number and date range' do
      reservation = @roomblock.book_reservation(1, @range)

      expect( reservation ).must_be_instance_of(Hotel::Reservation)
      expect( reservation.room ).must_equal(1)

    end
  end

  describe 'available_rooms' do
    before do
      @roomblock = Hotel::RoomBlock.new([*1..5], @range, 100)
    end

    it 'returns empty array if no rooms are available' do
      [*1..5].each do |i|
        @roomblock.book_reservation(i, @range)
      end

      expect( @roomblock.available_rooms ).must_equal([])
    end

    it 'correctly returns array of available rooms' do
      @roomblock.book_reservation(2, @range)
      expect( @roomblock.available_rooms).must_equal([1, 3, 4, 5])

      @roomblock.book_reservation(5, @range)
      expect( @roomblock.available_rooms).must_equal([1, 3, 4])
    end

    it 'returns all rooms if none are booked' do
      expect( @roomblock.available_rooms).must_equal([1, 2, 3, 4, 5])
    end
  end
end
