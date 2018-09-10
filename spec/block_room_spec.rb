require_relative 'spec_helper'


describe 'BlockRoom class' do
  describe 'Initializer' do

    before do
      @block_room = Hotel::BlockRoom.new()
    end

    it 'Creates an instance of BlockRoom' do
      expect(@block_room).must_be_kind_of Hotel::BlockRoom
    end

    it 'Correctly calculates a discounted rate for the room block reservation' do
    end






end
end
