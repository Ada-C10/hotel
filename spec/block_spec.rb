require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Block class" do

  describe "Block instantiation" do
    before do
      @block = Hotel::Block.new(block_id: nil,  number_of_rooms: nil, assigned_rooms: nil, start_date: nil, end_date: nil, discounted_price: nil)
    end

    it "is an instance of block" do
      expect(@block).must_be_kind_of Hotel::Block
    end
  end

  # describe "assign available rooms" do
  #   before do
  #     @block = Hotel::Block.new(id: 3, number_of_rooms: 3, assigned_rooms: @block.assign_available_room((Date.new(2018, 1, 1)), (Date.new(2018, 1, 2))), start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 2), discounted_price: 150)
  #   end
  #
  #   it "creates an array of available rooms" do
  #     expect(@block.assigned_rooms).must_be_kind_of Array
  #   end
  # end
  #

end
