require_relative 'spec_helper'

describe "Reservation Test" do
  describe "initialize" do
    it "has a check_in date & check_out date formated as Dates" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1)
      expect(new_Res.check_in).must_be_kind_of Date
      expect(new_Res.check_out).must_be_kind_of Date
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
  end
  describe "Reservation.cost method" do
    it "Calculates cost for 2 nights" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1)
      expect(new_Res.cost).must_equal 400
    end
  end
  describe "Reservation.date method" do
    it "Returns instance of reservation if includes date" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1)
      expect(new_Res.date("2018-09-05")[0]).must_equal new_Res
      expect(new_Res.date("2018-09-06")[0]).must_equal new_Res
      expect(new_Res.date("2018-09-07")[0]).must_equal new_Res
      expect(new_Res.date("2018-09-07")[0]).must_be_kind_of Reservation

    end
    it "Returns nil if there are no instances of reservations on that day" do
      new_Res = Reservation.new("2018-09-05","2018-09-07",1)
      expect(new_Res.date("2018-09-03")).must_be_nil
    end
  end
end
