require_relative 'spec_helper'

describe 'Block class' do
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
    Hotel::Block.new(Hotel::DateRange.new(check_in, check_out), blocked_rooms, discounted_rate, 1)
  }


  describe 'Block Instantiation' do
    it 'creates a Block object' do
      expect(block).must_be_instance_of Hotel::Block
    end

    it 'raises an error if given more than 5 rooms' do
      expect{Hotel::Block.new(check_in, check_out, [*1..6], discounted_rate, 1)}.must_raise ArgumentError
    end

    it 'raises an error if given an invaid discounted_rate' do
      expect{Hotel::Block.new(check_in, check_out, blocked_rooms, "Discounted Rate", 1)}.must_raise ArgumentError
      expect{Hotel::Block.new(check_in, check_out, blocked_rooms, 201, 1)}.must_raise ArgumentError
    end

    it 'raises an error if given a list of rooms with repeating room numbers' do
      expect{Hotel::Block.new(check_in, check_out, [1,1,1,1,1], discounted_rate, 1)}.must_raise ArgumentError
    end

    it 'raises an error if given a list of rooms with an room number less than 1 or greater than 20' do
      expect{Hotel::Block.new(check_in, check_out, [0, 1, 2, 3], discounted_rate, 1)}.must_raise ArgumentError
      expect{Hotel::Block.new(check_in, check_out, [19, 20, 21], discounted_rate, 1)}.must_raise ArgumentError
    end
  end

  describe 'get_block_availability' do
    it 'returns true if block has full availability' do
      expect(block.get_block_availability).must_equal true
    end

    # TODO:
    # it 'returns true if block any availability' do
    # skip
    # end

    # TODO:
    # it 'returns false if block has 0 availability' do
  end

end
