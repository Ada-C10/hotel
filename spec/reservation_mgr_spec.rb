require_relative 'spec_helper'

describe "ReservationMgr Test" do
  describe "initialize" do
    before do
      @new_ResMgr = ReservationMgr.new(3)
    end
    it "has an array of Rooms that 3 rooms long" do
      expect(@new_ResMgr.rooms).must_be_kind_of Array
      expect(@new_ResMgr.rooms.length).must_equal 3
    end
    it "has instances of Rooms at each index" do
      expect(@new_ResMgr.rooms[0]).must_be_kind_of Room
    end
    it "has an empty array of reservations at each index" do
      expect(@new_ResMgr.reservations).must_equal []
    end
  end

  describe "make_reservation method" do
    before do
      @new_ResMgr = ReservationMgr.new(3)
    end
    it "stores a new instance of a reservation if there are rooms available " do
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      expect(@new_ResMgr.reservations[0]).must_be_kind_of Reservation
    end
    it "returns and argument error if there are no rooms available" do
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      expect{@new_ResMgr.make_reservation("2018-09-05","2018-09-07")}.must_raise ArgumentError
    end
    it "will create two new reservations if someone wants two rooms" do
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07",rooms: 2)
      expect(@new_ResMgr.reservations.length).must_equal 2
    end
    it "will raise an argument error if not enough rooms are available" do
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      expect{@new_ResMgr.make_reservation("2018-09-05","2018-09-07",rooms: 2)}.must_raise ArgumentError
    end
    it "will take all forms of adding dates to reservations" do
      @new_ResMgr.make_reservation(Date.parse("2018-09-05"),"2018-09-07")
      @new_ResMgr.make_reservation("2018-09-07",Date.new(2018,9,9))
      expect(@new_ResMgr.reservations.length).must_equal 2
    end
    it "will add two seperations to one room if they are not on the same date" do
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      date_hash = {check_in: Date.parse("2018-09-05"), check_out: Date.parse("2018-09-07")}
      expect(@new_ResMgr.rooms[0].unavailable_dates[0]).must_equal date_hash

      @new_ResMgr.make_reservation("2018-09-07","2018-09-09")
      date_hash2 = {check_in: Date.parse("2018-09-07"), check_out: Date.parse("2018-09-09")}
      expect(@new_ResMgr.rooms[0].unavailable_dates[1]).must_equal date_hash2
      expect(@new_ResMgr.rooms[0].unavailable_dates.length).must_equal 2
    end
  end

  describe "reservations_by_date method" do
    before do
      @new_ResMgr = ReservationMgr.new(3)
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
    end
    it "creates an array of all the reservations for a particular day" do
      expect(@new_ResMgr.reservations_by_date("2018-09-05")).must_be_kind_of Array
      expect(@new_ResMgr.reservations_by_date("2018-09-05")[0]).must_be_kind_of Reservation
      expect(@new_ResMgr.reservations_by_date("2018-09-05").length).must_equal 3
    end
  end


end
