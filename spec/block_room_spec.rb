require_relative 'spec_helper'
require 'date'
require 'pry'

describe "Block_Room Class" do

  describe "initialize" do
    before do
      @date = Date.new(2028,8,8)
      @date2 = Date.new(2028,8,11)
      input = {
        name: "Wednesday Addams",
        room_number:  8,
        check_in_date: @date,
        check_out_date: @date2,
        block_name: "Munster - Addams Wedding",
        block_discount: 0.08,
      }
      @hotel_block = Hotel::Block_Room.new(input)
    end

    it 'it creates a reservation for a room as an instance of block rooms' do
      expect(@hotel_block).must_be_kind_of Hotel::Block_Room
    end

    it 'has a block discount associated with the block' do
      expect(@hotel_block.block_discount).must_equal 0.08
    end

    it 'has a check in & check out date and an array of the nights of stay' do
      expect(@hotel_block.check_in_date).must_be_kind_of Date
      expect(@hotel_block.check_in_date).must_equal @date
      expect(@hotel_block.nights_of_stay).must_be_kind_of Array
      expect(@hotel_block.nights_of_stay.length).must_equal 3
    end

    it 'has a name associated with the block' do
      expect(@hotel_block.block_name).must_equal "Munster - Addams Wedding"
    end

  end

end
