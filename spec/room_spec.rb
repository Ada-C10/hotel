require_relative 'spec_helper'

describe 'Room class' do
  it 'returns an instance of a room' do
    room = Room.new(1, "10/10/2010", "10/15/2010")
    expect(room).must_be_kind_of Room
  end
end
