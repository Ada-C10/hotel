require_relative 'spec_helper'

describe "Reservation class" do

  describe "Reservation initialization" do

    it "is an instance of Reservation" do
      @reservation = Hotel::Reservation.new(2015, 03, 01, 2015, 03, 05)
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "must throw an argument error if the end date is before the start date" do
      expect {Hotel::Reservation.new(2015, 03, 05, 2015, 03, 01)}.must_raise ArgumentError
    end
  end

  describe "Generate date" do
    it "is a kind of date" do

      date = Date.new(2018,1,3)
      expect(date).must_be_kind_of Date
    end
  end

end
