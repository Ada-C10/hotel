require_relative 'spec_helper'

describe "ReservationMgr Test" do
  describe "initialize" do
    before do
      @new_ResMgr = ReservationMgr.new
    end
    it "has an array of Rooms that 20 rooms long" do
      expect(@new_ResMgr.rooms).must_be_kind_of Array
      expect(@new_ResMgr.rooms.length).must_equal 20
    end
    it "has instances of Rooms at each index" do
      expect(@new_ResMgr.rooms[0]).must_be_kind_of Room
    end
  end



end
