
require_relative 'spec_helper.rb'

describe 'Room' do
  let (:room_number1) {
    1
  }

  let (:room_number2) {
    2
  }

  let (:room_number3) {
    3
  }

  let (:red_rum) {
    237
  }

  let (:standard_room) {
    Room.new(room_number1)
  }

  describe "#initialize" do
    # Test to make sure it takes correct parameters
    it 'Takes in a room number' do
      expect(standard_room).must_respond_to :room_number
      expect(standard_room.room_number).must_equal room_number1
    end
    # Test to make sure that rooms checked are only 1-20
    it 'Raise argument error for invalid room number' do
      expect{Room.new(red_rum)}.must_raise ArgumentError
    end
  end
end
