require_relative 'spec_helper'

describe 'Reservation class' do
  describe 'Initializer' do
    it 'is an instance of Reservation' do
      date1 = "Jan 11th 2019"
      date2 = "Jan 15th 2019"
      my_res = Reservation.new(date1, date2)

      expect(my_res).must_be_kind_of Reservation
    end
  end
end
