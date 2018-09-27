require_relative 'spec_helper'

describe 'Room' do
  it 'creates an instance of room' do
    new_room = Room.new(20)
    expect(new_room).must_be_kind_of Room
  end

  it 'checks if the room is unavailable on the specified date' do
    new_room = Room.new(15)
    reservation_date_1 = Date.new(2018, 9, 10)
    reservation_date_2 = Date.new(2018, 9, 11)
    date_to_check = Date.new(2018, 9, 11)
    new_room.dates_booked << reservation_date_1
    new_room.dates_booked << reservation_date_2

    expect(new_room.is_available?(date_to_check)).must_equal false
  end

  it 'checks if the room is available on the specified date' do
    new_room = Room.new(15)
    reservation_date_1 = Date.new(2018, 9, 10)
    reservation_date_2 = Date.new(2018, 9, 11)
    date_to_check = Date.new(2018, 9, 13)
    new_room.dates_booked << reservation_date_1
    new_room.dates_booked << reservation_date_2

    expect(new_room.is_available?(date_to_check)).must_equal true
  end

  it 'checks if the room is available for a block' do
    new_room = Room.new(15)
    reservation_date_1 = Date.new(2018, 9, 10)
    reservation_date_2 = Date.new(2018, 9, 11)
    date_to_check = Date.new(2018, 9, 13)
    new_room.dates_held_for_block << reservation_date_1
    new_room.dates_held_for_block << reservation_date_2

    expect(new_room.is_available_for_block?(date_to_check)).must_equal true
  end

  it 'checks if the room is unavailable for a block' do
    new_room = Room.new(15)
    reservation_date_1 = Date.new(2018, 9, 10)
    reservation_date_2 = Date.new(2018, 9, 11)
    date_to_check = Date.new(2018, 9, 11)
    new_room.dates_held_for_block << reservation_date_1
    new_room.dates_held_for_block << reservation_date_2

    expect(new_room.is_available_for_block?(date_to_check)).must_equal false
  end

  it 'returns the correct room price for a standard room' do
    new_room = Room.new(15)
    room_type = :standard
    price = new_room.price_per_night(room_type)

    expect(price).must_equal 200
  end

  it 'returns the correct room price for a block room' do
    new_room = Room.new(15)
    room_type = :block
    price = new_room.price_per_night(room_type)

    expect(price).must_equal 150
  end

  it 'raises a standard error if an invalid room type is entered' do
    new_room = Room.new(15)
    room_type = :luxury

    expect{new_room.price_per_night(room_type)}.must_raise StandardError
  end

  it 'updates the dates that a room is booked for' do
    new_room = Room.new(15)
    date_array = []
    date_array << Date.new(2018, 9, 10)
    date_array << Date.new(2018, 9, 11)
    date_array << Date.new(2018, 9, 12)

    room_booked_dates = new_room.update_dates_booked_for_room(date_array)
    expect(room_booked_dates.length).must_equal 3
  end

end
