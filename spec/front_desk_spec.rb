require_relative 'spec_helper'
require 'pry'

describe "FrontDesk class" do

  describe "create all rooms" do
    before do
      @rooms = Hotel::FrontDesk.create_rooms
    end
    it "creates an array of 20 rooms " do
      expect(@rooms.length).must_equal 20
    end
    it "the ID of the first room is 1" do
      expect(@rooms.first.room_number).must_equal 1
    end
    it "the ID of the last room is 20" do
      expect(@rooms.last.room_number).must_equal 20
    end
  end

  describe "all method" do
    it "Returns a list of all rooms in hotel" do
      @rooms = Hotel::FrontDesk.all
      expect(@rooms).must_be_kind_of Array
      expect(@rooms.length).must_equal 20
      @rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end
  end

end
