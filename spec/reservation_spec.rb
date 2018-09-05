require_relative 'spec_helper'

describe "Reservation" do
  describe "#initialize" do
    it "can be instantiated" do
      @reservation = Reservation.new
      expect(@reservation).must_be_kind_of Reservation
    end
  end
end
