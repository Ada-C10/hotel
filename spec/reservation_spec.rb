require_relative 'spec_helper'

describe 'Reservation class' do

  let (:reservation) {
    check_in = Date.new(2020, 1, 1)
    check_out = check_in + 2
    Hotel::Reservation.new(check_in, check_out, 1)
  }

  describe 'Reservation instantiation' do

    it 'creates an instance of Reservation' do
      expect(reservation).must_be_instance_of Hotel::Reservation
    end

  end

  describe 'get_cost method' do

    it 'returns the correct cost of a reservation' do
      expect(reservation.get_cost).must_equal BASE_COST * 2
    end


  end

end
