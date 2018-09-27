require_relative 'spec_helper'

describe 'BlockOfRooms class' do
  before do
    start_date = "Oct 1 2018"
    end_date = "Oct 4 2018"
    discounted_rate = 180
    @my_block = RoomBlock.new(start_date, end_date, room_cost: discounted_rate)
  end

  let (:invalid_block1) {
    date1 = "Jan 15th 2019"
    date2 = "Jan 11th 2019"
    RoomBlock.new(date1, date2, 180)
  }

  let (:invalid_block2) {
    date1 = "Jan 15th 2019"
    date2 = "Jan 15th 2019"
    RoomBlock.new(date1, date2, 180)
  }

  describe 'Initializer' do
    it 'is an instance of BlockOfRooms' do
      expect(@my_block).must_be_kind_of RoomBlock
      expect(@my_block.room_cost).must_equal 180
      expect(@my_block.dates_booked).must_be_kind_of Array
      expect(@my_block.dates_booked[0]).must_be_kind_of Date
    end

    it 'raises ArgumentError if check_in is later than check_out' do
      expect{ invalid_block1 }.must_raise ArgumentError
    end

    it 'raises ArgumentError if check_in and check_out are the same day' do
      expect{ invalid_block2 }.must_raise ArgumentError
    end
  end

  describe 'add_room' do
    it 'adds a collection of room instances' do

      @my_block.add_room(1)
      @my_block.add_room(2)

      expect(@my_block.collection_rooms.count).must_equal 2
    end
  end
end
