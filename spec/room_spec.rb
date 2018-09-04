require_relative 'spec_helper'

describe 'Room' do
  before do
    @room = Room.new()
  end

  it 'will initialize a room' do
    expect(@room).must_be_instance_of Room
  end
end
