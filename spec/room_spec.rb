require_relative 'spec_helper'

describe "initialize" do
  before do
    @new_room = Room.new(1)
  end

  it "creates a new instance of Room" do
    expect(@new_room).must_be_instance_of Room
  end

  it "has a room_number" do
    expect(@new_room.room_number).must_equal 1
  end

end

describe "is available?" do
  before do
    @new_room = Room.new(6)
    @new_room.add_reservation(Reservation.new(Date.new(2010, 3, 4), Date.new(2010, 3, 8), @new_room, 'customer'))
  end
  it "can check its own availability on a specific date range" do
    expect(@new_room.is_available?(Date.new(2010, 3, 5), (Date.new(2010, 3, 9)))).must_equal false
    expect(@new_room.is_available?(Date.new(2010, 3, 9), (Date.new(2010, 3, 11)))).must_equal true
  end
  it "considers a room to be available on the last day of a reservation" do
    expect(@new_room.is_available?(Date.new(2010, 3, 8), (Date.new(2010, 3, 15)))).must_equal true
  end
end
