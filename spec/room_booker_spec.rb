require_relative 'spec_helper.rb'

describe 'Wave 1' do
  before do
    @hotel = BookingLogic::RoomBooker.new
    @room_id = 14
    @check_in = Date.new(2018, 4, 1)
    @check_out = Date.new(2018, 4, 2)
    @reservation1 = @hotel.new_reservation(room_id, check_in, check_out)
  end

  describe 'list_rooms method' do
    it 'lists all rooms in the hotel' do
      expect(@hotel.list_rooms).must_be_kind_of Array
      expect(@hotel.list_rooms.length).must_equal 20
    end
  end

  describe 'new_reservation method' do
    it 'adds a new reservation to master collection' do
      expect(@hotel.reservations.last).must_be_instance_of Reservation
      expect(@hotel.reservations.last).must_equal @reservation
    end
  end

  describe 'list_reservations method' do
    it 'lists the reservations for a given date' do
      room_id = 15
      check_in = Date.new(2018, 4, 3)
      check_out = Date.new(2018, 4, 6)
      reservation2 = @hotel.new_reservation(room_id, check_in, check_out)

      given_date = Date.new(2018, 4, 1)
      listed_reservations = @hotel.list_reservations

      expect(listed_reservations).must_be_kind_of Array
      expect(listed_reservations.first).must_equal @reservation
      expect(listed_reservations.last).must_equal reservation2
    end
  end
end
