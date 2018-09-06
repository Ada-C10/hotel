require_relative 'spec_helper'

describe "Reservation Class: Wave One: Tracking Reservations" do
  describe "Reservation class initialize" do
    before do
      @reservation = Reservation.new('2018-02-03', '2018-02-05', 1)
    end

    it "creates a reservation" do
      expect(@reservation).must_be_instance_of Reservation
    end

    it "gives the reservation a cost" do
      expect(@reservation.cost).must_equal 400
    end

    it "generates an id for the reservation" do
      name_regexp = /^[a-z]{2}\d{3}$/
      expect(@reservation.reservation_id).must_match name_regexp
    end

    it "raises an error for invalid dates" do
      expect{Reservation.new('2018-02-15', '2018-02-05', 1)}.must_raise StandardError
    end
  end
end
