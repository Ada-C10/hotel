require_relative 'spec_helper'

describe 'initialize' do
  before do
    @room_1 = Room.new(1, 200)
    @room_2 = Room.new(2, 200)
  end

  let (:new_reservation) {Reservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 8), @room_1)}

  it 'creates a new reservation' do
    expect(new_reservation).is_a? Reservation
  end

  it 'raises an error for an invalid date range' do
    expect{
      Reservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 5), @room_1)
    }.must_raise StandardError
    expect{
      Reservation.new(Date.new(2018, 9, 5), Date.new(2015, 9, 5), @room_2)
    }.must_raise StandardError
  end

  it 'can calculate the price of the reservation' do
    expect(new_reservation.price).must_equal 600
  end


end
