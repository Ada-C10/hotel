require_relative 'spec_helper'

describe 'Room class' do
  it 'returns an instance of a room' do
    room = Room.new(1)
    expect(room).must_be_kind_of Room
  end
end


# describe 'Room Class' do
#   it "shows rooms availability" do
#     room = Room.new(3).availablity("10/5/2018", "14/5/2018")
#     expect(room).must_equal ":available"
#   end
#
# end
