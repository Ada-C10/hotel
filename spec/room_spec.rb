require_relative 'spec_helper'

describe 'Room' do
  it 'creates an instance of room' do
    new_room = Room.new(20)
    expect(new_room).must_be_kind_of Room
  end

end
