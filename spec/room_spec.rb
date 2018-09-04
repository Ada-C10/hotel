require_relative 'spec_helper'

describe "initialize" do
  before do
    @new_room = Room.new(1, 200)
  end

  it "creates a new instance of Room" do
    expect(@new_room).must_be_instance_of Room
  end

  it "has a room_number" do
    expect(@new_room.room_number).must_equal 1
  end

  it "has a price" do
    expect(@new_room.price_per_night).must_equal 200
  end



end
