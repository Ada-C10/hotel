require_relative 'spec_helper'
require 'date'

describe "Block instatiation" do
  before do
    @new_block = Block.new("2012-10-5", "2012-10-7", 100, [4,3,1])
    NAME_REGEXP = /^[A-Z]{2}\d{3}$/
  end
  it "returns an instance of Block" do
    expect(@new_block).must_be_instance_of Block
  end
  it "raises an error if more than 5 rooms are booked" do
    expect{@new_block2 = Block.new("2012-10-5", "2012-10-7", 100, [1,2,3,4,5,6])}.must_raise StandardError
  end
  it "creates a randomized id matching a regex" do
    expect(@new_block.block_ID).must_match NAME_REGEXP
  end
end
