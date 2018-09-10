require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Block class" do

  describe "Block instantiation" do
    before do
      @block = Hotel::Block.new(block_id: nil,  number_of_rooms: nil, start_date: nil, end_date: nil, price_per_night: nil)
    end

    it "is an instance of block" do
      expect(@block).must_be_kind_of Hotel::Block
    end
  end
end
