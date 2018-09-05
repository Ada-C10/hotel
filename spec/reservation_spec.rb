require_relative 'spec_helper'

describe "Reservation class" do

  describe "Reservation initialization" do

    it "is an instance of Reservation" do
      @reservation = Hotel::Reservation.new(2015, 03, 01, 2015, 03, 05)
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end


  end


end
