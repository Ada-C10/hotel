Require_relative 'spec_helper'

describe "hotel_rooms" do

  it "hotel_rooms will return a fixed value" do
    hotel_rooms.must_equal 20
  end

  it "Raises an ArgumentError when given invaild value" do
    expect{hotel_rooms[20]}.must_raise ArgumentError
  end
