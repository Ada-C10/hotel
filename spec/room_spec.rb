require_relative 'spec_helper.rb'

describe Hotel do
  describe 'initialize' do
    before do
      @room = Hotel::Room.new(1)
    end

    it 'creates a new instance of room' do
      expect(@room).must_be_kind_of Hotel::Room
    end

  end
end
