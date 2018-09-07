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

  describe "Room.create method" do
      num_rooms = 3
      new_rooms = Room.create(num_rooms)
    it "Provides a list of all rooms" do
      expect(new_rooms).must_be_kind_of Array
      expect(new_rooms[0]).must_be_kind_of Room
      expect(new_rooms.length).must_equal num_rooms
    end
  end

  describe "Room.is_available? method" do
    before do
      @check_in = Date.parse("2018-09-05")
      @check_out = Date.parse("2018-09-07")
      @new_room1 = Room.new(1)
      @new_room1.unavailable_dates << {check_in:@check_in,check_out:@check_out}
      @new_room2 = Room.new(2)
    end
    it "Returns false if room is unavailable" do
      expect(@new_room1.is_available?(@check_in,@check_out)).must_equal false
    end
    it "Returns true if room is available" do
      expect(@new_room2.is_available?(@check_in,@check_out)).must_equal true
    end
    it "Returns false if check_in and check_out overlap with existing reservations" do
      expect(@new_room1.is_available?(Date.new(2018,9,6),Date.new(2018,9,10))).must_equal false
      expect(@new_room1.is_available?(Date.new(2018,9,3),Date.new(2018,9,6))).must_equal false

    end
    it "Returns true if room check_out date is the same as new check_in date" do
      expect(@new_room1.is_available?(Date.new(2018,9,7),Date.new(2018,9,10))).must_equal true
    end
    it "Returns true if room check_in date is the same as new check_out date" do
      expect(@new_room1.is_available?(Date.new(2018,9,3),Date.new(2018,9,5))).must_equal true
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
    it "New unavailable dates are inserted as a hash" do
      expect(@new_room1.unavailable_dates[0]).must_be_kind_of Hash
    end
    it "Check that the check_in and check_out dates are added to hash" do
      expect(@new_room1.unavailable_dates[1][:check_in]).must_equal @check_in
      expect(@new_room1.unavailable_dates[1][:check_out]).must_equal @check_out
    end
    it "Sorts the unavailable_dates" do
      expect(@new_room1.unavailable_dates[0][:check_in]).must_be :<, @check_in
      expect(@new_room1.unavailable_dates[0][:check_out]).must_be :<=, @check_in
    end
  end
end
