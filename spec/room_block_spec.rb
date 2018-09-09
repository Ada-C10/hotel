require_relative 'spec_helper'

describe 'RoomBlock' do
  let(:room_block_two) {
    input = {
      checkin_date: "12/09/2018", checkout_date: "13/09/2018",
      confirmation_id: "BLOCK12345", room_number: [1,2], total_cost: 0.8 * 200 * 3,
      reservations: [], num_rooms: 3
    }
    Hotel::RoomBlock.new(input)
  }

  it 'will do initialize an instance of RoomBlock' do

    expect(room_block_two).must_be_kind_of Hotel::RoomBlock
  end
end
