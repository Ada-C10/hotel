require_relative 'spec_helper'

describe 'Block class' do
  let (:check_in) { Date.today }
  let (:check_out) { Date.today + 3 }
  let (:range) {Hotel::DateRange.new(check_in, check_out)}
  let (:blocked_rooms) { [*1..5] }
  let (:discounted_rate) { 150 }

  let (:block) { Hotel::Block.new(range, blocked_rooms, discounted_rate, 1) }

  let (:reservation) { [ Hotel::Reservation.new(range, 1, rate: 150)] }

  let (:fully_reserved) { 5.times.map { |room_num|
    Hotel::Reservation.new(range, room_num + 1, rate: 150) } }

  let (:block_with_res) { Hotel::Block.new(range, blocked_rooms, discounted_rate, 1, block_reservations: reservation ) }

  let (:full_block) { Hotel::Block.new(range, blocked_rooms, discounted_rate, 1, block_reservations: fully_reserved ) }


  describe 'Block Instantiation' do
    it 'creates a Block object' do
      expect(block).must_be_instance_of Hotel::Block
      expect(block).must_respond_to :date_range
      expect(block).must_respond_to :blocked_rooms
      expect(block).must_respond_to :discounted_rate
      expect(block).must_respond_to :block_id
    end

    it 'raises an error if given more than 5 rooms' do
      expect{Hotel::Block.new(range, [*1..6], discounted_rate, 1)}.must_raise ArgumentError
    end

    it 'raises an error if given an invaid discounted_rate' do
      expect{Hotel::Block.new(range, blocked_rooms, "Discounted Rate", 1)}.must_raise ArgumentError
      expect{Hotel::Block.new(range, blocked_rooms, 201, 1)}.must_raise ArgumentError
    end

    it 'raises an error if given a list of rooms with repeating room numbers' do
      expect{Hotel::Block.new(range, [1,1,1,1,1], discounted_rate, 1)}.must_raise ArgumentError
    end

    it 'raises an error if given a list of rooms with an room number less than 1 or greater than 20' do
      expect{Hotel::Block.new(range, [0, 1, 2, 3], discounted_rate, 1)}.must_raise ArgumentError
      expect{Hotel::Block.new(range, [19, 20, 21], discounted_rate, 1)}.must_raise ArgumentError
    end

    it 'raises an error if given a room that doesn\'t exist in hotel' do
      expect{Hotel::Block.new(range, [0, 1, 2, 3], discounted_rate, 1)}.must_raise ArgumentError
      expect{Hotel::Block.new(range, [19, 20, 21], discounted_rate, 1)}.must_raise ArgumentError
    end
  end

  describe 'is_number helper method' do
    it 'returns true if given an Integer' do
      expect(block.is_number(1)).must_equal true
    end

    it 'returns true if given a Float' do
      expect(block.is_number(1.0)).must_equal true
    end

    it 'returns false if given anything besides a Float or Integer' do
      expect(block.is_number("1")).must_equal false
      expect(block.is_number("1.0")).must_equal false
      expect(block.is_number("AA")).must_equal false
      expect(block.is_number(:sym)).must_equal false
      expect(block.is_number([1])).must_equal false
    end
  end

  describe 'get_block_availability' do
    it 'returns true if block has full availability' do
      expect(block.get_block_availability).must_equal true
    end

    it 'returns true if block any availability' do
      expect(block_with_res.get_block_availability).must_equal true
    end

    it 'returns false if block has no availability' do
      expect(full_block.get_block_availability).must_equal false
    end
  end

  describe 'list_available_block_rooms method' do
    it 'returns an array listing the available rooms in block' do
      expect(block_with_res.list_available_block_rooms).must_be_instance_of Array
      expect(block_with_res.list_available_block_rooms).must_equal [*2..5]
    end

    it 'returns an empty array [] if no rooms available' do
      expect(full_block.list_available_block_rooms).must_equal []
    end

    it 'returns all rooms in the block if all rooms available' do
      all_block_rooms = block.blocked_rooms
      expect(block.list_available_block_rooms).must_equal all_block_rooms
    end
  end

end
