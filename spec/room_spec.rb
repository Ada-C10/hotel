require_relative 'spec_helper'
require 'pry'

describe 'Room class' do

  describe "initialize" do

    it "is an instance of Room" do
      @room = Hotel::Room.new(2)
      expect(@room).must_be_kind_of Hotel::Room
    end


    it "contains a valid status" do
      valid_statuses = [:AVAILABLE, :UNAVAILABLE]
      valid_statuses.each do |status|
        @room = Hotel::Room.new(2, status)
        expect(@room.status).must_equal status
      end
    end


    it "sets the status to :AVAILABLE if no status is given" do
      @room = Hotel::Room.new(2)
      expect(@room.status).must_equal :AVAILABLE
    end


    it "must throw an argument error if an invalid status is given" do
      expect {Hotel::Room.new(2, :HUH)}.must_raise ArgumentError
    end


    it "accepts all valid ids" do
      valid_room_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

      valid_room_ids.each do |id|
        room = Hotel::Room.new(id)
        expect(room.room_id).must_equal id
      end
    end


    it "must throw an argument error if an invalid id is given" do
      bogus_room_ids = [53, 0, 'cool', -5, nil, :cool]
      bogus_room_ids.each do |id|
        expect {Hotel::Room.new(id)
        }.must_raise ArgumentError
      end
    end






  end



end
