require_relative 'spec_helper'

describe "Reservation" do
  let(:check_in) {
    "2018-09-15"
  }
  let(:check_out) {
    "2018-09-20"
  }
  let(:id) {
    1337
  }
  let(:room_number) {
    Hotel::Room.new(id)
  }
  let(:reservation) {
    Hotel::Reservation.new(room_number,check_in, check_out)
  }

  describe "#initialize" do
    it "Creates an instance of reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Keeps track of all parameters" do

      [:check_in, :check_out, :room_number].each do |variable|
        expect(reservation).must_respond_to variable
      end

      expect(reservation.check_in).must_equal Date.parse(check_in)
      expect(reservation.check_out).must_equal Date.parse(check_out)
      expect(reservation.room_number).must_equal room_number
    end

    it "raises a StandardError with invalid date range" do
      expect{
        Hotel::Reservation.new(room_number, check_out, check_in)
      }.must_raise StandardError
    end
  end

  describe "#total_cost" do
    it "Calculates the total cost for a reservation" do
      new_reservation = Hotel::Reservation.new(id, check_in, check_out)
      cost = new_reservation.total_cost

      expect(cost).must_equal 1000
    end

    it "Calculates the total cost for a reservation with a discounted rate" do
      new_reservation = Hotel::Reservation.new(id, check_in, check_out, room_rate: 150)
      cost = new_reservation.total_cost

      expect(cost).must_equal 750
    end
  end
end
