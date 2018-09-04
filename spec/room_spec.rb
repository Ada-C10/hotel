require_relative 'spec_helper'

describe 'Room Wave 1' do
  describe 'initialize' do
    it 'creates a room number' do
      new_room = Lodging::Room.new(46)

      expect(new_room).must_respond_to :room_number
      expect(new_room).must_be_instance_of Lodging::Room
    end
  end
end
