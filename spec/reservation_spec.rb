require_relative 'spec_helper'

describe 'initialize' do
  before do
    @room_1 = Room.new(1)
    @room_2 = Room.new(2)
  end

  let (:new_reservation) {Reservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 8), @room_1, 'customer')}

  it 'creates a new reservation' do
    expect(new_reservation).is_a? Reservation
  end

  it 'raises an error for an invalid date range' do
    expect{
      Reservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 5), @room_1, 'customer')
    }.must_raise StandardError
    expect{
      Reservation.new(Date.new(2018, 9, 5), Date.new(2015, 9, 5), @room_2, 'customer')
    }.must_raise StandardError
  end

  it 'can calculate the price of the reservation' do
    expect(new_reservation.price).must_equal 600
  end
end

describe 'Block initialize' do
  before do
    @room_1 = Room.new(1)
    @room_2 = Room.new(2)
  end

  let (:new_reservation) {BlockReservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 8), [@room_1, @room_2], 150, 'Block1')}

  it 'creates a new reservation' do
    expect(new_reservation).is_a? BlockReservation
  end

  it 'raises an error for an invalid date range' do
    expect{
      BlockReservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 5), [@room_1, @room_2], 150, 'Block1')
    }.must_raise StandardError
    expect{
      BlockReservation.new(Date.new(2018, 9, 5), Date.new(2015, 9, 5), [@room_1, @room_2], 150, 'Block1')
    }.must_raise StandardError
  end

  it 'can calculate the price of a reservation in the block' do
    expect(new_reservation.price).must_equal 450
  end

  it 'raises an error if the block size is more than 5 rooms' do
    expect{
      BlockReservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 10), [@room_1, @room_2, 'fake room', 'fake room', 'fake room', 'fake room'], 150, 'Block1')
    }.must_raise ArgumentError
  end
end
