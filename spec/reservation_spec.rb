require_relative 'spec_helper'

describe "Reservation" do
  let(:start_date) {
    "2018-09-15"
  }
  let(:end_date) {
    "2018-09-20"
  }
  let(:id) {
    1337
  }
  let(:room_number) {
    Hotel::Room.new(id)
  }
  let(:reservation) {
    Hotel::Reservation.new(room_number,start_date: start_date, end_date: end_date)
  }

  describe "#initialize" do
    it "Creates an instance of reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Keeps track of all parameters" do
      expect(reservation.start_date).must_equal Date.parse(start_date)
      expect(reservation.end_date).must_equal Date.parse(end_date)
      expect(reservation.room_number).must_equal room_number
    end

    it "raises a StandardError with invalid date range" do
      end_date = "2018-09-15"
      start_date = "2018-09-20"
      expect{
        Hotel::Reservation.new(room_number, end_date: end_date, start_date: start_date)
      }.must_raise StandardError
    end
  end

  describe "#total_cost" do
    it "Calculates the total cost for a reservation" do
      expect(reservation.total_cost).must_equal 1000
    end

    it "Calculates the total cost for a reservation with a discounted rate" do
      new_reservation = Hotel::Reservation.new(id, start_date: start_date, end_date: end_date, room_rate: 150)

      expect(new_reservation.total_cost).must_equal 750
    end
  end
end
