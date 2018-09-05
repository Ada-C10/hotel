require_relative 'spec_helper'

describe "Reservation" do

  let (:reservation) {
    Reservation.new("SoccerMom2010@gmail.com", 1, [Date.new(2018,10,20),Date.new(2018,10,22)])
  }
  let (:reservation2) {
    Reservation.new("Guccifer2.0@ada.com", 1, [Date.new(2018,12,02),Date.new(2018,12,07)])
  }
  let (:reservation3) {
    Reservation.new("Jfahmy07@gmail.com", 2, [Date.new(2018,12,03),Date.new(2018,12,06)])
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

  describe "Reservation#retrieve_by_date" do
    it "raises an argument error if invalid date object is provided" do
      expect{ (retrieve_by_date("I am a string")) }.must_raise ArgumentError
    end

    it "returns an array of the reservations relevant to that date" do
      test_date = retrieve_by_date(Date.new(2018,12,04))

      expect(test_date).must_be_instance_of Array
      expect(test_date.first).must_be_instance_of Reservation
      expect(test_date.length).must_equal 2
    end
  end

end
