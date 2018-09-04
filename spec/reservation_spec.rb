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

  it 'raises an ArgumentError if an invalid room is entered' do
    reservation_num = 666
    room_num = 30
    start_date = "2018,10,6"
    end_date = "2018,10,8"
    room_type = :standard

    expect{Reservation.new(reservation_num, room_num, start_date, end_date, room_type)}.must_raise ArgumentError
  end

  it 'raises an ArgumentError if the start date is later than the end date' do
    reservation_num = 666
    room_num = 15
    start_date = "2018,10,11"
    end_date = "2018,10,6"
    room_type = :standard

    expect{Reservation.new(reservation_num, room_num, start_date, end_date, room_type)}.must_raise ArgumentError
  end

  it 'raises an ArgumentError if an invalid room type is entered' do
    reservation_num = 666
    room_num = 15
    start_date = "2018,10,10"
    end_date = "2018,10,15"
    room_type = :deluxe

    expect{Reservation.new(reservation_num, room_num, start_date, end_date, room_type)}.must_raise ArgumentError
  end

  it 'correctly calculates duration of trip' do
    reservation_num = 5555
    room_num = 1
    start_date = "2018,9,10"
    end_date = "2018,9,12"
    room_type = :standard

    new_reservation = Reservation.new(reservation_num, room_num, start_date, end_date, room_type)

    expect(new_reservation.duration).must_equal 2
  end

end
