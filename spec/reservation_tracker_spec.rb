require_relative 'spec_helper'

describe 'ReservationTracker class' do
  it 'creates a new instance of ReservationTracker' do
    new_tracker = ReservationTracker.new()
    expect(new_tracker).must_be_kind_of ReservationTracker
  end

  it 'shows available rooms for a given date range'do
    new_tracker = ReservationTracker.new()
    start_date = "2018,9,10"
    end_date = "2018,9,15"
    rooms_available = new_tracker.show_available_rooms(start_date, end_date)
    expect(rooms_available.length).must_equal 20
  end
end
