require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "Create an instance of room" do
      room = Room.new(19, :available)
      room.must_be_kind_of Room
    end

    it "keeps track of room number" do
      room = Room.new(19, :available)
      room.must_respond_to :room_number
      room.room_number.must_equal 19
    end

    it "keeps track of status" do
      room = Room.new(19, :available)
      room.must_respond_to :status
      room.status.must_equal :available
    end
  end
end
