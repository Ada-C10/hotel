require_relative 'spec_helper'

describe 'initialize' do
  let (:new_reservation) {
    Reservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 8), 1)
  }


  it 'creates a new reservation' do
    expect(@new_res).is_a? Reservation
  end

  it 'raises an error for an invalid date range' do
    expect{
      Reservation.new(Date.new(2018, 9, 5), Date.new(2018, 9, 5), 1)
    }.must_raise StandardError
  end

end
