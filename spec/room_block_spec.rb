# require_relative 'spec_helper'
# require 'pry'
#
# describe "Room Block class" do
#
#   describe "Room Block initialization" do
#
#     it "is an instance of a Room Block" do
#
#       block_id = 1
#       start_date = Date.new(2015, 03, 01)
#       end_date = Date.new(2015, 03, 05)
#       room_ids = [1,2,3,4]
#
#       @room_block = Hotel::RoomBlock.new(4, start_date, end_date, room_ids)
#       expect(@room_block).must_be_kind_of Hotel::RoomBlock
#     end
#
#     it "must throw an argument error if the end date is before the start date" do
#       start_date = Date.new(2015, 03, 05)
#       end_date = Date.new(2015, 03, 01)
#       expect {Hotel::RoomBlock.new(start_date, end_date)}.must_raise ArgumentError
#     end
#   end
#
# end
