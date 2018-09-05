require_relative 'spec_helper'

describe 'Room' do
  it 'creates an instance of room' do
    new_room = Room.new(20)
    expect(new_room).must_be_kind_of Room
  end

  it 'checks if the room is available on the specified date' do
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

end
