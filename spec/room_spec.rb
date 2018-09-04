require_relative 'spec_helper'

describe 'Room' do
  before do
    @room = Hotel::Room.new()
  end

  describe 'initialize' do

    it 'will initialize on instance of a room' do
      expect(@room).must_be_instance_of Hotel::Room
    end

    it 'will initialize one new room with a room_number 1-20' do
      skip
    end

  end




end
