require_relative 'spec_helper'

describe Reservation do
  describe "#initialize" do
    before do
      @reservation = Reservation.new('181202', '181204')
    end
    it "can be instantiated" do
      expect(@reservation).must_be_kind_of Reservation
    end
    it "takes check_in and check_out" do
      expect(@reservation).must_respond_to :check_in
      expect(@reservation).must_respond_to :check_out
    end
    # it "raises StandardError if check_in isn't 6 digits" do
    #   expect(Reservation.new(20181202, 2)).must_raise StandardError, "Invalid check-in date format."
    # end
    it "converts check_in to Date object" do
      expect(@reservation.check_in).must_be_kind_of Date
      # expect(@reservation.check_in).must_equal 2018-12-02
    end
    it "calculates and stores number of nights" do
      expect(@reservation.number_of_nights).must_equal 2
    end
    it "calculates and stores cost" do
      expect(@reservation.cost).must_equal 400
      expect(@reservation).must_respond_to :cost
    end
  end

  # describe "#get_all_dates" do
  #   it "returns Array" do
  #     @reservation = Reservation.new(181202, 2)
  #     expect(@reservation.get_all_dates).must_be_kind_of Array
  #   end
  #   it "contains all dates for reservation" do
  #     @reservation = Reservation.new(181202, 2)
  #     expect(@reservation.get_all_dates.length).must_equal 2
  #     expect(@reservation.get_all_dates[0]).must_be_kind_of Date
  #     expect(@reservation.get_all_dates[1]).must_be_kind_of Date
  #   end
  # end
end
