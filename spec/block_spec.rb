require 'simplecov'
SimpleCov.start
require_relative 'spec_helper'

describe 'Block Class' do
  it 'creates a new instance of a block' do
    check_in_date = Date.new(2018, 9, 5)
    check_out_date = Date.new(2018, 9, 8)
    new_block = Block.new(check_in_date, check_out_date, 5)
    expect(new_block).must_be_instance_of Block
  end

  it 'charges a rate of 100 for the BLOCKRATE' do
    Block::BLOCKRATE.must_equal 100
  end

  it 'block of rooms must equal 5' do
    check_in_date = Date.new(2018, 9, 5)
    check_out_date = Date.new(2018, 9, 8)
    new_block = Block.new(check_in_date, check_out_date, 5)
    expect(new_block.block_of_rooms).must_equal 5
  end
end

describe 'validate block of rooms' do
  it 'raises an Argument Error, if there are more than 5 rooms in a block' do
    check_in_date = Date.new(2018, 9, 5)
    check_out_date = Date.new(2018, 9, 8)
    new_block = Block.new(check_in_date, check_out_date, 6)
    expect { new_block.valid_block_of_rooms }.must_raise ArgumentError
  end
end
