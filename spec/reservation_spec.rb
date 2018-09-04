require_relative 'spec_helper'

describe 'Reservation' do
  before do
    @reservation = Reservation.new("31/08/2018", "03/09/2018")
  end

  describe 'initialize' do

    it 'will initialize on instance of a reservation' do
      expect(@reservation).must_be_instance_of Reservation
    end

    it 'will throw an argument error if checkout before checkin' do
      expect { Reservation.new("03/09/2018", "31/08/2018") }.must_raise StandardError
    end

    it 'will calculate correct cost' do

      expect(@reservation.total_cost).must_equal 3 * 200
    end

  end




end
