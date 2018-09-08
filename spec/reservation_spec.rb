require_relative 'spec_helper'

describe "Reservation" do
  let (:reservation) {
    Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: 1, date_range: (Date.new(2018,10,20)...Date.new(2018,10,22))})
  }
  let (:reservation2) {
    Reservation.new({guest_id: "Guccifer2.0@ada.com", room: 1, date_range: (Date.new(2018,12,02)...Date.new(2018,12,07))})
  }
  let (:reservation3) {
    Reservation.new({guest_id: "Jfahmy07@gmail.com", room: 2, date_range: (Date.new(2018,12,03)...Date.new(2018,12,06))})
  }
  let (:reservation4) {
    Reservation.new({guest_id: "JimmyCricket@gmail.com", room: 5, status: :block_reserved, date_range: (Date.new(2018,12,03)...Date.new(2018,12,06))})
  }

  describe "#initialize" do

    it "creates a reservation object" do
      expect(reservation).must_be_instance_of Reservation
    end

    it "returns a guest id as an email" do
      expect(reservation.guest_id).must_equal "SoccerMom2010@gmail.com"
    end

    it "returns a room id" do
      expect(reservation.room).must_equal 1
    end

    it "returns a date range for guests stay" do
        expect(reservation.date_range).must_equal (Date.new(2018,10,20)...Date.new(2018,10,22))
    end

    it "returns default nightly rate" do
      expect(reservation.rate).must_equal 200.00
    end

    it "return default status as complete" do
      expect(reservation.status).must_equal :complete
    end

  end

  describe "Reservation#valid_date_range" do

  end

  describe "Reservation#stay_cost" do
    it "will calculate cost of guest's stay" do
      expect(reservation2.stay_cost).must_equal 1000.00
    end
  end

  describe "Reservation#complete_reservation" do
    it "will set a reservations status to complete" do
      reservation4.complete_reservation
      expect(reservation4.status).must_equal :complete
    end
  end


end
