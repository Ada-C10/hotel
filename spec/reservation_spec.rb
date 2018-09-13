#reservation spec
require_relative 'spec_helper'

describe Reservation do

  describe "Reservation instantiation" do
    let (:start_date) { Date.parse('2012-02-01') }
    let (:end_date) { Date.parse('2012-02-03') }
    let (:room) { 12 }
    let (:bookings) {[12, 14]}
    describe "#initialize" do
      it "Takes start and end dates" do

        reservation = Reservation.new(start_date,end_date, room)

        expect(reservation).must_respond_to :start_date
        expect(reservation.start_date).must_equal start_date

        expect(reservation).must_respond_to :end_date
        expect(reservation.end_date).must_equal end_date
      end
    end

describe "I can get the total cost for a given reservation" do
    describe "#calculate_total_cost" do
    it "Takes start and end dates and calculates total cost of room" do

       reservation_test = Reservation.new(start_date, end_date, room)


         expect(reservation_test.calculate_total_cost).must_equal 400
end
end


end
end
