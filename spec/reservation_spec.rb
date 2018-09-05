require_relative 'spec_helper'

describe "Reservation" do
  describe "#initialize" do
    let(:check_in) {
      "2018-09-15"
    }
    let(:check_out) {
      "2018-09-20"
    }
    let(:room) {
      Hotel::Room.new(1)
    }
    let(:reservation) {
      Hotel::Reservation.new(check_in, check_out, room)
    }

    it "Creates an instance of reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Keeps track of Instance Variables" do

      [:check_in, :check_out, :room].each do |variable|
        expect(reservation).must_respond_to variable
      end

      expect(reservation.check_in).must_equal Date.parse(check_in)
      expect(reservation.check_out).must_equal Date.parse(check_out)
      expect(reservation.room).must_equal room
    end

    it "raises a StandardError with invalid date range" do
    end
  end

  describe "#total_cost" do
    it "Calculates the total cost for a reservation" do
      new_reservation = Hotel::Reservation.new("2018-10-07", "2018-10-15", 1)
      cost = new_reservation.total_cost

      expect(cost).must_equal 1600
    end
  end
end
