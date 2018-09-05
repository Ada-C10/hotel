require_relative 'spec_helper'

describe 'ReservationTracker class' do
  it 'creates a new instance of ReservationTracker' do
    new_tracker = ReservationTracker.new()
    expect(new_tracker).must_be_kind_of ReservationTracker
  end

  it 'shows all rooms in the hotel' do
    new_tracker = ReservationTracker.new()
    all_rooms = new_tracker.show_all_hotel_rooms
    expect(all_rooms.length).must_equal 20
  end

  it 'shows available rooms for a given date range when there are no existing bookings'do
    new_tracker = ReservationTracker.new()
    start_date = "2018,9,10"
    end_date = "2018,9,15"
    rooms_available = new_tracker.show_available_rooms(start_date, end_date)
    expect(rooms_available.length).must_equal 20
  end

  it 'shows available rooms for a given date range when there is single prexisting booking' do
    new_tracker = ReservationTracker.new()
    start_date = "2018,9,10"
    end_date = "2018,9,15"
    date_booked = Date.new(2018, 9, 10)
    first_room = new_tracker.all_rooms.first
    first_room.dates_booked << date_booked
    rooms_available = new_tracker.show_available_rooms(start_date, end_date)

    expect(rooms_available.length).must_equal 19

  end
end
