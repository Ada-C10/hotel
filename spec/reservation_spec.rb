require_relative 'spec_helper'

describe "Reservation" do

  let (:reservation) {
    Reservation.new("SoccerMom2010@gmail.com", 1, [Date.new(2018,10,20),Date.new(2018,10,22)])
  }

  describe "#initialize" do

    it "creates a reservation object" do
      expect(reservation).must_be_instance_of Reservation
    end

    it "returns a guest id as an email" do
      expect(reservation.guest_id).must_equal "SoccerMom2010@gmail.com"
    end

    it "returns a room id" do
      expect(reservation.room_id).must_equal 1
    end

    it "returns a date range from guests stay" do
        expect(reservation.date_range).must_equal [Date.new(2018,10,20),Date.new(2018,10,22)]
    end

    it "can calculate guest's stay cost and return it" do
      expect(reservation.cost).must_equal 400.00
    end
  end
end
