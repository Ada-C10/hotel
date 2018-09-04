require_relative 'spec_helper'

describe 'Reservation class' do

  let (:reservation) {
    start_date = Date.new(2020, 1, 1)
    end_date = start_date + 2
    Hotel::Reservation.new(start_date, end_date, 1)
  }

  describe 'Reservation instantiation' do

    it 'creates an instance of Reservation' do
      expect(reservation).must_be_instance_of Hotel::Reservation
    end

  end

  describe 'get_cost method' do

    it 'returns the correct cost of a room' do
      expect(reservation.get_cost).must_equal BASE_COST * 2
    end


  end

end
