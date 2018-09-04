
require_relative 'spec_helper.rb'

describe "initialize" do
  it 'Takes in a room number and avaliability status' do
    room_number = 5
    avaliability = :avaliable
    test_room = Room.new(room_number, avaliability)

    expect(test_room).must_respond_to :room_number
    expect(test_room.room_number).must_equal room_number

    expect(test_room).must_respond_to :avaliability
    expect(test_room.avaliability).must_equal avaliability

  end
end
