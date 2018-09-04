require_relative 'spec_helper'

describe 'Room class' do

  describe "initialize" do

    it "is an instance of Room" do
      @room = Hotel::Room.new()
      expect(@room).must_be_instance_of Hotel::Room
    end


    it "contains a valid status" do
      valid_statuses = [:AVAILABLE, :UNAVAILABLE]
      valid_statuses.each do |status|
        @room = Hotel::Room.new(status)
        expect(@room.status).must_equal status
      end
    end


    it "sets the status to :AVAILABLE if no status is given" do
      @room = Hotel::Room.new()
      expect(@room.status).must_equal :AVAILABLE
    end


    it "must throw an argument error if an invalid status is given" do  
      expect {Hotel::Room.new(:HUH)}.must_raise ArgumentError
    end


  end


#must have a valid status
#must throw argument error without valid status?







end
