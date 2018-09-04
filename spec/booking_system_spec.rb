require_relative 'spec_helper'

describe 'BookingSystem class' do
  it 'is an instance of BookingSystem' do
    booking = BookingSystem.new

    expect(booking).must_be_kind_of BookingSystem
  end
end
