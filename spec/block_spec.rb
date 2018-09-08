require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Block class" do

  describe "Block instantiation" do
    before do
      @block = Hotel::Block.new(id: 3, number_of_rooms: 3, assigned_rooms: [3, 4, 5], start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 2), discounted_price: 150)
    end

    it "is an instance of block" do
      expect(@block).must_be_kind_of Hotel::Block
    end
  end
end
