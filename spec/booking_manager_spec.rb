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
      expect(sample_booking.rooms[0]).must_be_kind_of Hash

    end
  end

  # describe "#book_reservation" do
  #   # check info within the reservations array
  #
  #   it 'must fill the reservations array with stuff' do
  #     expect(sample_booking.reservations).must_equal 4 # 4 nithgs from 1st to 5th
  #   end
  #
  #   it 'must contain hashes' do
  #     expect(sample_booking.reservations[0]).must_be_kind_of Hash
  # end

end
