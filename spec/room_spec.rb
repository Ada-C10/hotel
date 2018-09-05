require_relative 'spec_helper'

describe 'Room class' do
  describe 'Room instantiation' do
    it 'creates an instance of room' do
      expect(Hotel::Room.new(1)).must_be_instance_of Hotel::Room
    end

    it 'raises an ArgumentError if given an invalid room number' do
      expect{Hotel::Room.new(21)}.must_raise ArgumentError
    end
  end
end
