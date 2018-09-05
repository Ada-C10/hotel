require_relative 'spec_helper.rb'

describe 'Reservation' do
  let (:room) {
    Room.new(5)
  }
  let (:check_in) {
    Date.new(2001, 1, 1)
  }
  let (:check_out) {
    Date.new(2001, 1, 7)
  }
  let (:general_reservation) {
    Reservation.new(room, check_in, check_out)
  }

  let (:throwback_date) {
    Date.new(1980, 4, 10)
  }


  describe "#initialize" do
    it 'Takes in a room number and availability status' do

      expect(general_reservation).must_respond_to :room
      expect(general_reservation.room).must_equal room

      expect(general_reservation).must_respond_to :check_in
      expect(general_reservation.check_in).must_equal check_in

      expect(general_reservation).must_respond_to :check_out
      expect(general_reservation.check_out).must_equal check_out

    end

    it 'Raises an argument error if check out date is before check in date' do

      expect{Reservation.new(room, check_in, throwback_date )}.must_raise ArgumentError

    end
  end

  describe "#total_charge" do
    it 'Charges 200.00 a night for a reservation' do
      # general reservation is for 7 days, 6 nights, 6 * 200 = 1200
      expect(general_reservation.total_charge).must_equal 1200
    end
  end

  describe "#stay_duration" do
    it 'Calculates the amount of time that the reservation is active' do
      #general reservation for 6 nights
      expect (general_reservation.stay_duration).must_equal 6

    end

  end
end
