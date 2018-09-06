require_relative 'spec_helper'

describe 'room class' do
  describe 'initialize' do
    it 'creates a new instance of room' do
      new_rooms = Lodging::Room.new(20)

      expect(new_rooms).must_be_instance_of Lodging::Room
    end
  end
end
