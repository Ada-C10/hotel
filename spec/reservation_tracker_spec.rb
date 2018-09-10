require_relative 'spec_helper'

describe 'ReservationTracker class' do
  before do
    @new_tracker = ReservationTracker.new()
  end

  it 'creates a new instance of ReservationTracker' do
    expect(@new_tracker).must_be_kind_of ReservationTracker
  end

  it 'shows all rooms in the hotel' do
    all_rooms = @new_tracker.show_all_hotel_rooms
    expect(all_rooms.length).must_equal 20
  end

  it 'shows available rooms for a given date range when there are no existing bookings'do
    start_date = "2018,9,10"
    end_date = "2018,9,15"
    rooms_available = @new_tracker.show_available_rooms(start_date, end_date)
    expect(rooms_available.length).must_equal 20
  end

  it 'shows available rooms for a given date range when there is single prexisting booking' do
    start_date = "2018,9,10"
    end_date = "2018,9,15"
    date_booked = Date.new(2018, 9, 10)
    first_room = @new_tracker.all_rooms.first
    first_room.dates_booked << date_booked
    rooms_available = @new_tracker.show_available_rooms(start_date, end_date)

    expect(rooms_available.length).must_equal 19
  end

  it 'makes a reservation number' do
    new_reservation_number = @new_tracker.make_reservation_number
    expect(new_reservation_number).must_equal 1
  end

  it 'will reserve an available room ' do
    room_num = 3
    check_in = "2018,9,10"
    check_out = "2018,9,15"
    new_reservation = @new_tracker.reserve_room(room_num, check_in, check_out)
    expect(@new_tracker.all_reservations.length).must_equal 1
  end

  it 'will not reserve an unavailable room' do
    date_booked_1 = Date.new(2018, 9, 10)
    date_booked_2 = Date.new(2018, 9, 11)
    first_room = @new_tracker.all_rooms.first
    first_room.dates_booked << date_booked_1
    first_room.dates_booked << date_booked_2

    conflicting_room_num = first_room.room_number
    check_in = "2018,9,10"
    check_out = "2018,9,11"
    expect{@new_tracker.reserve_room(conflicting_room_num, check_in, check_out)}.must_raise StandardError
  end

  it 'will make a reservation that starts on the same day that another reservation for the same room ends' do
    room_num_1 = 1
    check_in_1 = "2018,9,1"
    check_out_1 = "2018,9,2"
    new_reservation_1 = @new_tracker.reserve_room(room_num_1, check_in_1, check_out_1)

    room_num_2 = 1
    check_in_2 = "2018,9,2"
    check_out_2 = "2018,9,3"
    new_reservation_2 = @new_tracker.reserve_room(room_num_2, check_in_2, check_out_2)

    expect(@new_tracker.all_reservations.length).must_equal 2
  end

  it 'shows all reservations' do
    room_num_1 = 3
    check_in_1 = "2018,9,10"
    check_out_1 = "2018,9,12"
    new_reservation_1 = @new_tracker.reserve_room(room_num_1, check_in_1, check_out_1)

    room_num_2 = 4
    check_in_2 = "2018,9,10"
    check_out_2 = "2018,9,12"
    new_reservation_2 = @new_tracker.reserve_room(room_num_2, check_in_2, check_out_2)

    expect(@new_tracker.show_all_reservations.length).must_equal 2
  end

  it 'returns the total cost of the reservation' do
    reservation_num = 5555
    room_num = 1
    start_date = Date.new(2018,9,6)
    end_date = Date.new(2018,9,8)
    room_type = :standard

    new_reservation = Reservation.new(reservation_num, room_num, start_date, end_date, room_type)

    @new_tracker.all_reservations << new_reservation
    total_cost = @new_tracker.cost_of_reservation(reservation_num)
    expect(total_cost).must_equal 400
  end

  it 'shows reservations for a specific date' do
    room_num_1 = 3
    check_in_1 = "2018,9,10"
    check_out_1 = "2018,9,12"
    new_reservation_1 = @new_tracker.reserve_room(room_num_1, check_in_1, check_out_1)

    room_num_2 = 4
    check_in_2 = "2018,9,10"
    check_out_2 = "2018,9,12"
    new_reservation_2 = @new_tracker.reserve_room(room_num_2, check_in_2, check_out_2)

    room_num_3 = 5
    check_in_3 = "2018,5,10"
    check_out_3 = "2018,5,12"
    new_reservation_3 = @new_tracker.reserve_room(room_num_3, check_in_3, check_out_3)

    reservations_for_date = @new_tracker.show_reservations_per_date("2018,9,10")

    expect(reservations_for_date.length).must_equal 2
  end

  it 'raises a StandardError if an invalid date range is entered' do
    check_in = Date.new(2018,9,10)
    check_out = Date.new(2018,9,5)

    expect{@new_tracker.is_date_range_valid(check_in, check_out)}.must_raise StandardError
  end

end
