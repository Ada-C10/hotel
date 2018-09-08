require_relative 'spec_helper'

describe "Reservation Test" do
  describe "initialize" do
    it "has a check_in date & check_out date formated as Dates" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1)
      expect(new_Res.check_in).must_be_kind_of Date
      expect(new_Res.check_out).must_be_kind_of Date
      expect(new_Res.block_available).must_equal false
      expect(new_Res.block_id).must_be_nil
    end
    it "raises an Argument Error when an invalid date is entered in either check_in or check_out" do
      expect{Reservation.new("2018-09-05","2018-09-31",1)}.must_raise ArgumentError
      expect{Reservation.new("2018-09-31","2018-10-01",1)}.must_raise ArgumentError
    end
    it "raises an Argument Error when check-in date is after the check-out date" do
      expect{Reservation.new("2018-09-07","2018-09-05",1)}.must_raise ArgumentError
    end
    it "raises an Argument Error when an invalid room number is inserted" do
      expect{Reservation.new("2018-09-05","2018-09-07",23)}.must_raise ArgumentError
    end
    it "the block_available instance variable will be true if block_id is associated" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",2,block_id: "Metzner")
      expect(new_Res.block_available).must_equal true
    end

  end
  describe "Reservation.cost method" do
    it "Calculates cost for 2 nights" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1)
      expect(new_Res.cost).must_equal 400
    end
    it "Calculates a discounted cost for block reservation" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1,block_id: "Metzner")
      expect(new_Res.cost).must_equal 320
    end
  end
  describe "Reservation.date method" do
    it "Returns true if reservation includes given date" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1)
      expect(new_Res.date?("2018-09-05")).must_equal true
      expect(new_Res.date?("2018-09-06")).must_equal true
      expect(new_Res.date?("2018-09-07")).must_equal true

    end
    it "Returns false if there are no instances of reservations on that day" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1)
      expect(new_Res.date?("2018-09-03")).must_equal false
    end
  end
end
