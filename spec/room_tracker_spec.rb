#room_tracker


require_relative 'spec_helper'

describe Room_Tracker do

  describe "Reservation instantiation" do
    describe "#initialize" do
      it "Takes start and end dates" do

        start_date = Date.parse('2012-02-01')
        end_date = Date.parse('2012-02-03')
        reservation = Reservation.new(start_date,end_date)

        expect(reservation).must_respond_to :start_date
        expect(reservation.start_date).must_equal start_date

      end
    end
  end
end
