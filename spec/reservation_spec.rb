require_relative 'spec_helper'

describe 'Reservation class' do
  let (:valid_res) {
    room = 1
    date1 = "Jan 11th 2019"
    date2 = "Jan 15th 2019"
    Reservation.new(room, date1, date2)
  }

  let (:invalid_res1) {
    room = 1
    date1 = "Jan 15th 2019"
    date2 = "Jan 11th 2019"
    Reservation.new(room, date1, date2)
  }

  let (:invalid_res2) {
    room = 1
    date1 = "Jan 15th 2019"
    date2 = "Jan 15th 2019"
    Reservation.new(room, date1, date2)
  }

  describe 'Initializer' do
    it 'is an instance of Reservation' do
      expect(valid_res).must_be_kind_of Reservation
      expect(valid_res.room_cost).must_equal 200
      expect(valid_res.dates_booked).must_be_kind_of Array
      expect(valid_res.dates_booked[0]).must_be_kind_of Date
    end

    it 'raises ArgumentError if check_in is later than check_out' do
      expect{ invalid_res1 }.must_raise ArgumentError
    end

    it 'raises ArgumentError if check_in and check_out are the same day' do
      expect{ invalid_res2 }.must_raise ArgumentError
    end
  end

  describe 'date_range' do
    it 'returns an array of dates excluding check_out date' do
      expect(valid_res.dates_booked.first).must_equal Date.parse("Jan 11th 2019")
      expect(valid_res.dates_booked.last).must_equal Date.parse("Jan 14th 2019")
    end
  end

  describe 'length_of_stay' do
    it 'calculates the length_of_stay' do
      expect(valid_res.length_of_stay).must_equal (Date.parse("Jan 15 2019") - Date.parse("Jan 11 2019"))
    end
  end

  describe 'total_cost' do
    it 'calculates the total_cost of a reservation' do
      expect(valid_res.total_cost).must_equal 4 * 200
    end
  end
end
