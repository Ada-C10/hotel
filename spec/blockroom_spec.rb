require_relative 'spec_helper'

# Takes a date range
# Collection of rooms that are available for this date range - Max of 5 rooms
# If room is a block room, it cannot be resrved for another block/the public
# block room reservation = All rooms will match the block date range
# Block rooms should handle same logic given wave 2
# Discounted room rate

# Admin can check if block has any rooms available
# Admin can reserve a room from a block of rooms
describe "block room initalization" do

it "can be initalized" do
# need a date range/collection of rooms, discounted rate

expect( BlockRoom.new( Date.new(2018, 9, 1), Date.new(2018, 9, 2), [], 150 ) ).kind_of BlockRoom

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
