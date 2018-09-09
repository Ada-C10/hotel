require_relative 'spec_helper'

# Takes a date range
# Collection of rooms that are available for this date range - Max of 5 rooms
# If room is a block room, it cannot be resrved for another block/the public
# block room reservation = All rooms will match the block date range
# Block rooms should handle same logic given wave 2
# Discounted room rate

# Admin can check if block has any rooms available
# Admin can reserve a room from a block of rooms
describe "block room initialization" do

  before do
    @block_room = BlockRoom.new( Date.new(2018, 9, 1), Date.new(2018, 9, 2), 150 )
  end

  it "can be initialized" do
    # need a date range/collection of rooms, discounted rate
    expect(@block_room).kind_of? BlockRoom
  end

  it "Has a start date/end date" do
    expect(@block_room).respond_to? :start_date
    expect(@block_room.start_date).kind_of? Date
    expect(@block_room).respond_to? :end_date
    expect(@block_room.end_date).kind_of? Date
  end

  it "Has a discounted rate" do
    expect(@block_room).respond_to? :discounted_rate
  end
end

describe "reservations" do
  it "throws an error if you try to reserve more than 5 rooms" do

  end

  it "has all the reservations have the same check_in/check_out as the block room" do

  end

  it "does not allow other blocks to reserve the rooms" do

  end

  it "does not allow regular reservations to reserve block room reservations" do

  end

  it "can be checked if a block has any rooms available" do

  end

  it "can reserve a room from a block of rooms" do

  end


end
