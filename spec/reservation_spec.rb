require_relative 'spec_helper'

describe 'Reservation class' do
  let (:check_in) {
    Date.today
  }
  let (:check_out) {
    check_in + 2
  }
  let (:reservation) {
    Hotel::Reservation.new(Hotel::DateRange.new(check_in, check_out), 1)
  }

  describe 'Reservation instantiation' do

    it 'creates an instance of Reservation' do
      expect(reservation).must_be_instance_of Hotel::Reservation

      expect(reservation.date_range).must_respond_to :check_in
      expect(reservation.date_range).must_respond_to :check_out
      expect(reservation.room_num).must_equal 1
    end

    it 'raises an argument error if room_num is not a number' do
      expect{
        Hotel::Reservation.new(check_in, check_out, 'Not a number')
      }.must_raise ArgumentError

      expect{
        Hotel::Reservation.new(check_in, check_out, nil)
      }.must_raise ArgumentError

      expect{
        Hotel::Reservation.new(check_in, check_out, " ")
      }.must_raise ArgumentError
    end



  end

  describe 'get_cost method' do

    it 'returns the correct cost of a reservation' do
      rate = 200
      expect(reservation.get_cost(rate)).must_equal rate * 2
    end


  end

end
