require_relative 'spec_helper'

describe 'Reservation class' do
  let (:valid_res) {
    date1 = "Jan 11th 2019"
    date2 = "Jan 15th 2019"
    Reservation.new(date1, date2)
  }

  let (:invalid_res1) {
    date1 = "Jan 15th 2019"
    date2 = "Jan 11th 2019"
    Reservation.new(date1, date2)
  }

  let (:invalid_res2) {
    date1 = "Jan 15th 2019"
    date2 = "Jan 15th 2019"
    Reservation.new(date1, date2)
  }

  describe 'Initializer' do
    it 'is an instance of Reservation' do
      expect(valid_res).must_be_kind_of Reservation
    end

    it 'raises ArgumentError if check_in is later than check_out' do
      expect{ invalid_res1 }.must_raise ArgumentError
    end

    it 'raises ArgumentError if check_in and check_out are the same day' do
      expect{ invalid_res2 }.must_raise ArgumentError
    end
  end

  describe 'reservation_dates' do
    it 'returns an array of dates' do
      my_dates = valid_res.reservation_dates
      expect(my_dates).must_be_kind_of Array
    end

    it 'returns an array with reservation dates but excluding check_out_date' do
      my_dates = valid_res.reservation_dates
      expect(my_dates[0]).must_equal Date.parse("Jan 11th 2019")
      expect(my_dates[1]).must_equal Date.parse("Jan 12th 2019")
      expect(my_dates[2]).must_equal Date.parse("Jan 13th 2019")
      expect(my_dates[3]).must_equal Date.parse("Jan 14th 2019")
    end
  end

end
