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

  let (:check_out2) {
    Date.new(1980, 4, 10)
  }


  describe "#initialize" do
    # Test to make sure it takes correct parameters
    it 'Takes in a room number and availability status' do

      expect(general_reservation).must_respond_to :room
      expect(general_reservation.room).must_equal room

      expect(general_reservation).must_respond_to :check_in
      expect(general_reservation.check_in).must_equal check_in

      expect(general_reservation).must_respond_to :check_out
      expect(general_reservation.check_out).must_equal check_out

    end

    it 'raises an argument error if check out date is before check in date' do

      expect{Reservation.new(room, check_in, check_out2 )}.must_raise ArgumentError

    end
  end
end
