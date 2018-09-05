require_relative 'spec_helper'
require 'date'

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
  end
end
