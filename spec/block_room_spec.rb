require_relative 'spec_helper'

describe 'BlockRoom class' do
  describe 'Initializer' do

    before do
      @date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
      @block_room = Hotel::BlockRoom.new(@date_range_1, [1,2,3,4,5])
    end

    it 'Creates an instance of BlockRoom' do
      expect(@block_room).must_be_kind_of Hotel::BlockRoom
    end

    it 'Takes date range as an instance of DateRange' do
      expect(@block_room.date_range).must_be_kind_of Hotel::DateRange
    end

    it 'Takes block rooms as an array' do
      expect(@block_room.block_rooms).must_equal [*1..5]
    end

  end


end
