require_relative 'spec_helper'

describe 'Room class' do
  describe 'Initializer' do
    it 'is an instance of Room' do
      room = Room.new(1)

      expect(room).must_be_kind_of Room
    end
  end
end
