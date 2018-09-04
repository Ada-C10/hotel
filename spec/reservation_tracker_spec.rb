require_relative 'spec_helper'

describe 'ReservationTracker class' do
  it 'creates a new instance of ReservationTracker' do
    new_tracker = ReservationTracker.new()
    expect(new_tracker).must_be_kind_of ReservationTracker
  end
end
