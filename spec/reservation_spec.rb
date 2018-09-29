require_relative 'spec_helper'

describe 'Reservation' do

  it 'creates an instance of Reservation' do
    room_instance = Room.new(1)
    room_num = 1
    start_date = Date.new(2018,9,6)
    end_date = Date.new(2018,9,8)
    room_type = :standard

    new_reservation = Reservation.new(room_instance, room_num, start_date, end_date, room_type)

    expect(new_reservation).must_be_kind_of Reservation
  end

  it 'raises an StandardError if an invalid room is entered' do
    room_instance = Room.new(15)
    room_num = 30
    start_date = Date.new(2018,10,6)
    end_date = Date.new(2018,10,8)
    room_type = :standard

    expect{Reservation.new(room_instance, room_num, start_date, end_date, room_type)}.must_raise StandardError
  end

  it 'raises an StandardError if the start date is later than the end date' do
    room_instance = Room.new(15)
    room_num = 15
    start_date = Date.new(2018,10,11)
    end_date = Date.new(2018,10,6)
    room_type = :standard

    expect{Reservation.new(room_instance, room_num, start_date, end_date, room_type)}.must_raise StandardError
  end

  it 'raises an StandardError if an invalid room type is entered' do
    room_instance = Room.new(15)
    room_num = 15
    start_date = Date.new(2018,10,10)
    end_date = Date.new(2018,10,15)
    room_type = :deluxe

    expect{Reservation.new(room_instance, room_num, start_date, end_date, room_type)}.must_raise StandardError
  end

  it 'correctly calculates duration of trip' do
    room_instance = Room.new(1)
    room_num = 1
    start_date = Date.new(2018,9,10)
    end_date = Date.new(2018,9,12)
    room_type = :standard

    new_reservation = Reservation.new(room_instance, room_num, start_date, end_date, room_type)

    expect(new_reservation.duration).must_equal 2
  end

  it 'correctly calculates total cost of a reservation for a standard booking' do
    room_instance = Room.new(1)
    room_num = 1
    start_date = Date.new(2018,9,10)
    end_date = Date.new(2018,9,12)
    room_type = :standard

    new_reservation = Reservation.new(room_instance, room_num, start_date, end_date, room_type)

    expect(new_reservation.total_cost).must_equal 400
  end

  it 'updates booked dates for a room instance' do
    room_instance = Room.new(1)
    room_num = 1
    start_date = Date.new(2018,9,6)
    end_date = Date.new(2018,9,8)
    room_type = :standard

    new_reservation = Reservation.new(room_instance, room_num, start_date, end_date, room_type)

    new_reservation.update_room_booked_dates
    expect(room_instance.dates_booked.length).must_equal 2
  end

end
