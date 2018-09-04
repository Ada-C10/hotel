require_relative 'spec_helper'

describe 'Reservation class' do

  describe 'Reservation instantiation' do
    before do
      @start_date = Date.new(2020, 1, 1)
      @end_date = @start_date + 2
    end

    it 'creates an instance of Reservation' do
      reservation = Hotel::Reservation.new(@start_date, @end_date, 1)
      expect(reservation).must_be_instance_of Hotel::Reservation
    end
  end

end
