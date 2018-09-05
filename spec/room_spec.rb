require_relative 'spec_helper'
require 'pry'

describe "Room class" do

  describe "room instatiation" do

    it "is an instance of room" do
      @room = Hotel::Room.new(1)
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "has a room number" do
      @room = Hotel::Room.new(1)
      expect(@room.room_number).must_equal 1
    end

    it "returns argument error if the ID is not 1-20" do
      expect{Hotel::Room.new(29)}.must_raise ArgumentError
    end

  end


  end



  
