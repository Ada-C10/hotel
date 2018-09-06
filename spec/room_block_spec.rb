require_relative 'spec_helper'

describe 'RoomBlock class' do
  let (:check_in) {
    Date.today
  }
  let (:check_out) {
    Date.today + 3
  }
  let (:blocked_rooms) {
    [*1..5]
  }
  let (:discounted_rate) {
    150
  }

  let (:block) {
    Hotel::RoomBlock.new(check_in, check_out, blocked_rooms, discounted_rate)
  }


  describe 'RoomBlock Instantiation' do
    it 'creates a RoomBlock object' do
      expect(block).must_be_instance_of Hotel::RoomBlock
    end

    it 'raises an error if given more than 5 rooms' do
      expect{Hotel::RoomBlock.new(check_in, check_out, [*1..6], discounted_rate)}.must_raise ArgumentError
    end

    it 'raises an error if given an invaid discounted_rate' do
      expect{Hotel::RoomBlock.new(check_in, check_out, blocked_rooms, "Discounted Rate")}.must_raise ArgumentError
    end

    it 'raises an error if given a list of rooms with repeating room numbers' do
      expect{Hotel::RoomBlock.new(check_in, check_out, [1,1,1,1,1], discounted_rate)}.must_raise ArgumentError
    end

    it 'raises an error if given a list of rooms with an room number less than 1 or greater than 20' do
      expect{Hotel::RoomBlock.new(check_in, check_out, [0, 1, 2, 3], discounted_rate)}.must_raise ArgumentError
      expect{Hotel::RoomBlock.new(check_in, check_out, [19, 20, 21], discounted_rate)}.must_raise ArgumentError
    end
  end
end
