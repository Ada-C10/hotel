require 'simplecov'
SimpleCov.start
require_relative 'spec_helper'


describe 'Initialize' do
  it 'takes a room number' do
    room_number = 1
    room = Room.new(room_number)

    expect(room).must_respond_to :room_number
    expect(room.room_number).must_equal room_number
  end
end

describe 'is room available method' do
  before do
    room = Room.new(15)
    @reservation = Reservation.new(Date.new(2018, 1, 1), Date.new(2018, 1, 10), room)
  end

  it 'can check its availability on a specific date' do
    expect(room.is_room_available?(Date.new(2018, 1, 2))).must_equal false
    expect(room.is_room_available?(Date.new(2018, 1, 11))).must_equal true
  end

  it 'has a room to be available on the last day of a reservation' do
    expect(room.is_room_available?(Date.new(2018, 1, 11))).must_equal true
  end
end
