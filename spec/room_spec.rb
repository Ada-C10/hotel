require_relative 'spec_helper'

describe "Room class" do
  before do
    @room = Hotel::Room.new(
      room_number: 1,
      status: :AVAILABLE
    )
  end

  describe "Room instantiation" do
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "throws an argument error with a bad Room Number" do
      expect{
        Hotel::Room.new(
          room_number: 0,
        )
      }.must_raise ArgumentError

      expect{
        Hotel::Room.new(
          room_number: 21,
        )
      }.must_raise ArgumentError
    end

    it "throws an argument error with an invalid status" do
      expect{
        Hotel::Room.new(
          room_number: 1,
          status:'available'
        )
      }.must_raise ArgumentError
    end
  end
end
