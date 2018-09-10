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
