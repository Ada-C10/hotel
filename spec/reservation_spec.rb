require_relative 'spec_helper'

describe 'Reservation' do
  it 'creates an instance of Reservation' do
    reservation_num = 5555
    room_num = 1
    start_date = "2018,9,6"
    end_date = "2018,9,8"
    room_type = :standard

    new_reservation = Reservation.new(reservation_num, room_num, start_date, end_date, room_type)

    expect(new_reservation).must_be_kind_of Reservation
  end

end
