require_relative 'spec_helper.rb'

describe 'BookingManager' do

  let (:sample_booking) {
    BookingManager.new
  }

  let (:sample_checkin) {
    Date.new(2001,3,1)
  }

  let (:sample_checkout) {
    Date.new(2001,3,5)
  }

  describe '#initialize' do

    it 'must create an array of 20 room hashes when created' do
      expect(sample_booking.rooms).must_be_kind_of  Array
      expect(sample_booking.rooms.length).must_equal 20
      expect(sample_booking.rooms[0]).must_be_kind_of Integer

    end
  end

  describe '#find_available_room' do
    it 'must return a valid room number' do
      expect(sample_booking.find_available_room(sample_checkin, sample_checkout)).must_be_kind_of Integer
    end

    it 'must equal a number greater than 0' do
      expect(sample_booking.find_available_room(sample_checkin, sample_checkout)).must_be :>, 0
    end

    it 'must equal a number less than 21' do
      expect(sample_booking.find_available_room(sample_checkin, sample_checkout)).must_be :<, 21
    end
  end

  describe '#make_reservation' do
    it 'must return a reservation object' do
      expect(sample_booking.make_reservation(sample_checkin, sample_checkout)).must_be_kind_of Reservation
    end


  end

end
