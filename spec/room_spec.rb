require_relative 'spec_helper'

describe "Room Test" do
  describe "initialize" do
    before do
      @new_room = Room.new(1)
    end
    it "is an instance of Room" do
      expect(@new_room).must_be_kind_of Room
    end
  end

  describe "Room.list method" do
      new_room = Room.new(1)
      new_room2 = Room.new(2)
      new_room3 = Room.new(3)
    it "Provides a list of all rooms" do
      expect(Room.list).must_be_kind_of Array
      expect(Room.list[0]).must_be_kind_of Room
      #expect(Room.list.length).must_equal 3
    end
  end

  describe "Room.is_available? method" do
    before do
      @check_in = Date.parse("2018-09-05")
      @check_out = Date.parse("2018-09-07")
      @new_room1 = Room.new(1)
      @new_room1.unavailable_dates = (@check_in...@check_out).to_a
      @new_room2 = Room.new(2)
    end
    it "Provides room number if the room is available" do
      expect(@new_room1.is_available?(@check_in,@check_out)).must_equal 0
    end
    it "Provides zero if room number is not available" do
      expect(@new_room2.is_available?(@check_in,@check_out)).must_equal 2
    end
  end

  describe "Room.add_unavailable_dates method" do
    before do
      @check_in = Date.parse("2018-09-05")
      @check_out = Date.parse("2018-09-07")
      @new_room1 = Room.new(1)
      @new_room1.add_unavailable_dates(@check_in,@check_out)
      @new_room1.add_unavailable_dates(Date.parse("2018-09-01"),Date.parse("2018-09-05"))
    end
    it "Provides room number if the room is available" do
      expect(@new_room1.unavailable_dates[0]).must_be_kind_of Hash
    end
    it "Provides zero if room number is not available" do
      expect(@new_room1.unavailable_dates[0][:check_in]).must_equal @check_in
      expect(@new_room1.unavailable_dates[0][:check_out]).must_equal @check_out
    end
    it "Sorts the unavailable_dates" do
      expect(@new_room1.unavailable_dates[0][:check_in]).must_be :<, @check_in
      expect(@new_room1.unavailable_dates[0][:check_out]).must_be :<=, @check_in
    end
  end
end
