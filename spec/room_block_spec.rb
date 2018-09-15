require_relative 'spec_helper'
require 'pry'

describe "Room Block class" do

  describe "room block initialization" do

    before do
      reservation_dates = [1,2,3]
      room_ids = [4,5,6]
      block_id = 1

      @room_block = Hotel::RoomBlock.new(reservation_dates, room_ids, block_id)
    end

    it "is an instance of a Room Block" do
      expect(@room_block).must_be_kind_of Hotel::RoomBlock
    end

    it "is initialized with a date range, room ids and block id" do

      expect(@room_block).must_respond_to :reservation_dates
      expect(@room_block.reservation_dates).must_be_kind_of Array

      expect(@room_block).must_respond_to :room_ids
      expect(@room_block.room_ids).must_be_kind_of Array

      expect(@room_block).must_respond_to :block_id
      expect(@room_block.block_id).must_be_kind_of Integer

    end




  end
end
