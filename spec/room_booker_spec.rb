require_relative 'spec_helper.rb'

describe 'Wave 1' do
  describe 'list_rooms method' do
    it 'lists all rooms in the hotel' do
      hotel = BookingLogic::RoomBooker.new

      expect(hotel.list_rooms).must_be_kind_of Array
      expect(hotel.list_rooms.length).must_equal 20
    end
  end

  describe 'new_reservation method' do
    it 'adds a new reservation to master collection' do
      room_id = 14
      check_in = Date.new(2018, 4, 1)
      check_out = Date.new(2018, 4, 2)
      reservation = hotel.new_reservation(room_id, check_in, check_out)

      expect(@reservations.last).must_be_instance_of Reservation
      expect(@reservations.last).must_equal reservation
    end
  end
end
