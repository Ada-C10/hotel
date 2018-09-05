require_relative 'spec_helper'

describe 'BlockRoom' do

  it 'creates an instance of BlockRoom' do
    event_name = "AdaCon"
    start_date = "2018, 9, 10"
    end_date = "2018, 9, 15"
    new_block = BlockRoom.new(event_name, start_date, end_date)

    expect(new_block).must_be_kind_of BlockRoom
  end
end
