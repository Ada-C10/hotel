require_relative 'spec_helper'

describe 'initialize' do
  let (:new_reservation) {
    Reservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 8), 1)
  }
  let (:room) {
    Room.new(1, 200)
  }

  it 'creates a new reservation' do
    expect(new_reservation).is_a? Reservation
  end

  it 'raises an error for an invalid date range' do
    expect{
      Reservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 5), 1)
    }.must_raise StandardError
    expect{
      Reservation.new(Date.new(2018, 9, 5), Date.new(2015, 9, 5), 2)
    }.must_raise StandardError
  end



end
