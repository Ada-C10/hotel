require_relative 'spec_helper'

describe 'BookingSystem' do
  before do
    rs1 = Hotel::Reservation.new(102, "Sam Pull", [2], "January 1, 2019", "January 10, 2019")
    rs2 = Hotel::Reservation.new(103, "Bulldog Betty", [19], "October 22, 2019", "October 25, 2019")
    rs3 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "May 12, 2019", "May 13, 2019")
  end

  describe 'it can find reservation data' do
    let(:finder) do
      find_date = "October 22 2019"
      Hotel::BookingSystem.find_reservations_by_date(find_date)
    end
    it 'given a date, can find a reservation' do
      expect((finder).length).must_equal 3
    end
    it 'returns an array of reservations on that date' do
      expect(finder).must_be_kind_of Array
    end
    it 'returns an array of reservation instances' do
      expect(finder[0]).must_be_kind_of Hotel::Reservation
    end
    it 'returns 0 if no reservations found on that day' do
      expect(Hotel::BookingSystem.find_reservations_by_date("May 4 2020")).must_equal 0
    end
    it 'can find a reservation given an id' do
      id = 1
      expect(Hotel::BookingSystem.find_a_reservation(id)).must_be_kind_of Hotel::Reservation
    end
    it 'raises an argument error if no reservation are found w/ that id' do
      id = 9999
      expect{ Hotel::BookingSystem.find_a_reservation(id) }.must_raise ArgumentError
    end
    it 'can get total cost given a reservation id' do
      id = 2 # 1 room, 1 night, baserate 200.00
      expect(Hotel::BookingSystem.get_reservation_total(id)).must_equal 1 * 1 * 200.00
      expect(Hotel::BookingSystem.get_reservation_total(id)).must_be_kind_of Float
    end
    it 'can find available rooms given a date' do
      find_date = "October 23 2019"
      expect(Hotel::BookingSystem.find_available_rooms(find_date)).must_be_kind_of Array
      expect((Hotel::BookingSystem.find_available_rooms(find_date)).length).must_equal 18
      find_date2 = "March 15 2020"
      expect((Hotel::BookingSystem.find_available_rooms(find_date2)).length).must_equal 20
    end


  end
  # it 'can make a reservation' do
  #   # expect(Hotel::BookingSystem.new_reservation).must_be_kind_of Hotel::BookingSystem
  # end
end