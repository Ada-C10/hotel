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
    it "will add two instances of res to one room if they are not on the same date" do
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      date_hash = {check_in: Date.parse("2018-09-05"), check_out: Date.parse("2018-09-07"), block_id: nil, block_available: false}
      expect(@new_ResMgr.rooms[0].unavailable_dates[0]).must_equal date_hash

      @new_ResMgr.make_reservation("2018-09-07","2018-09-09")
      date_hash2 = {check_in: Date.parse("2018-09-07"), check_out: Date.parse("2018-09-09"), block_id: nil, block_available: false}
      expect(@new_ResMgr.rooms[0].unavailable_dates[1]).must_equal date_hash2
      expect(@new_ResMgr.rooms[0].unavailable_dates.length).must_equal 2
    end
    it "will reserve a block room that is available if someone puts in a block party" do
      @new_ResMgr.reserve_block(Date.parse("2018-09-05"),Date.parse("2018-09-07"),2,"Metzner")
      res = @new_ResMgr.make_reservation(Date.parse("2018-09-05"),Date.parse("2018-09-07"),block_id: "Metzner")
      expect(res[0].block_available).must_equal false
    end
    it "will raise an argument error if the block room checkin checkout dates don't match what they want to reserve" do
      @new_ResMgr.reserve_block(Date.parse("2018-09-05"),Date.parse("2018-09-07"),2,"Metzner")
      expect{@new_ResMgr.make_reservation(Date.parse("2018-09-06"),Date.parse("2018-09-07"),block_id: "Metzner")}.must_raise ArgumentError
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

  describe "reservation_cost method" do
    before do
      @new_ResMgr = ReservationMgr.new(3)
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      @new_ResMgr.make_reservation("2018-09-05","2018-09-10")
      @new_ResMgr.make_reservation("2018-09-30","2018-10-07")
    end
    it "returns cost for a given reservation" do
      expect(@new_ResMgr.reservation_cost(@new_ResMgr.reservations[0])).must_equal 400
      expect(@new_ResMgr.reservation_cost(@new_ResMgr.reservations[1])).must_equal 1000
      expect(@new_ResMgr.reservation_cost(@new_ResMgr.reservations[2])).must_equal 1400
    end
  end

  describe "available_rooms method" do
    before do
      @new_ResMgr = ReservationMgr.new(3)
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      @new_ResMgr.make_reservation("2018-09-05","2018-09-10")
      @new_ResMgr.make_reservation("2018-09-30","2018-10-07")
    end
    it "returns array of available rooms" do
      expect(@new_ResMgr.available_rooms("2018-09-05","2018-09-07")).must_be_kind_of Array
      expect(@new_ResMgr.available_rooms("2018-09-05","2018-09-07").length).must_equal 1
      expect(@new_ResMgr.available_rooms("2018-11-05","2018-11-07").length).must_equal 3
    end
    it "will raise and argument error if check_in date is greater than check_out date" do
      expect{@new_ResMgr.available_rooms("2018-09-07","2018-09-05")}.must_raise ArgumentError
    end
  end

  describe "reserve_block method" do
    before do
      @new_ResMgr = ReservationMgr.new(6)
    end
    it "method reserves 5 rooms with false id" do
      block = @new_ResMgr.reserve_block(Date.parse("2018-09-05"),Date.parse("2018-09-07"),5,"Metzner")
      expect(block.length).must_equal 5
      expect(@new_ResMgr.reservations[0].block_available).must_equal true
      @new_ResMgr.make_reservation("2018-09-05","2018-09-07")
      expect(@new_ResMgr.reservations.last.block_available).must_equal false
    end
    it "will raise an argument error if they try to block more than 5 rooms" do
      expect{@new_ResMgr.reserve_block(Date.parse("2018-09-05"),Date.parse("2018-09-07"),6,"Metzner")}.must_raise ArgumentError
    end
    it "will raise an arguemnt error if there are not enough available rooms for a given date range" do
      @new_ResMgr.make_reservation(Date.parse("2018-09-05"),Date.parse("2018-09-07"))
      @new_ResMgr.make_reservation(Date.parse("2018-09-05"),Date.parse("2018-09-07"))
      @new_ResMgr.make_reservation(Date.parse("2018-09-05"),Date.parse("2018-09-07"))
      expect{@new_ResMgr.reserve_block(Date.parse("2018-09-05"),Date.parse("2018-09-07"),4,"Metzner")}.must_raise ArgumentError
    end
  end

  describe "find_available_block_rooms method" do
    before do
      @new_ResMgr = ReservationMgr.new(6)
    end
    it "returns rooms in block that have not been reserved" do
      block = @new_ResMgr.reserve_block(Date.parse("2018-09-05"),Date.parse("2018-09-07"),5,"Metzner")
      expect(@new_ResMgr.find_available_block_rooms("Metzner").length).must_equal 5
      expect(@new_ResMgr.find_available_block_rooms("Metzner")[0]).must_be_kind_of Reservation
    end
    it "raises an argument error if no rooms are available in that block" do
      expect{@new_ResMgr.find_available_block_rooms("Metzner")}.must_raise ArgumentError
    end
  end

  #find_available_block_rooms(block_id)

end
