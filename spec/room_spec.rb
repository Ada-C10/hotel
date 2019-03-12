require_relative 'spec_helper'

describe "#Room - initialize method" do
  before do
    @Room = Room.new(number: 1)
  end

  it "is an instance of a Room" do
    expect(@Room).must_be_kind_of Room
  end

  it "has a room number" do
    expect(@Room.number).must_equal 1
  end
end
