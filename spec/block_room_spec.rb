require_relative 'spec_helper'

describe 'BlockRoom' do

  it 'creates an instance of BlockRoom' do
    event_name = "AdaCon"
    start_date = "2018, 9, 10"
    end_date = "2018, 9, 15"
    room_instances = [Room.new(15), Room.new(14)]
    new_block = BlockRoom.new(event_name, start_date, end_date, room_instances)

    expect(new_block).must_be_kind_of BlockRoom
  end
end
