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
  let (:reservation) {
    Reservation.new(room, check_in, check_out)
  }


  describe "#initialize" do

    # Test to make sure it takes correct parameters
    it 'Takes in a room number and availability status' do

      expect(reservation).must_respond_to :room
      expect(reservation.room).must_equal room

      expect(reservation).must_respond_to :check_in
      expect(reservation.check_in).must_equal check_in

      expect(reservation).must_respond_to :check_out
      expect(reservation.check_out).must_equal check_out

      # it 'raises an argument error if check out date is before check in date' do
      #
      #   bad_checkout = Date.new(1999, 1, 1)
      #   expect {R}.must_raise ArgumentError
      # end

    end
  end
end
