require_relative 'spec_helper.rb'

describe 'Wave 1' do
  before do
    @hotel = BookingLogic::RoomBooker.new

    room_id1 = 14
    check_in1 = Date.new(2018, 4, 1)
    check_out1 = Date.new(2018, 4, 2)
    @reservation1 = @hotel.new_reservation(room_id1, check_in1, check_out1)

    room_id2 = 15
    check_in2 = Date.new(2018, 4, 3)
    check_out2 = Date.new(2018, 4, 6)
    @reservation2 = @hotel.new_reservation(room_id2, check_in2, check_out2)
  end

  describe 'list_rooms method' do
    it 'lists all rooms in the hotel' do
      expect(@hotel.list_rooms).must_be_kind_of Array
      expect(@hotel.list_rooms.length).must_equal 20
    end
  end

  describe 'new_reservation method' do
    it 'adds a new reservation to master collection' do
      expect(@hotel.reservations.first).must_be_instance_of BookingLogic::Reservation
    end
  end

  describe 'list_reservations method' do
    it 'lists the reservations for a given date' do
      given_date = Date.new(2018, 4, 1)
      listed_reservations = @hotel.list_reservations

      expect(listed_reservations).must_be_kind_of Array
      expect(listed_reservations.first).must_equal @reservation
      expect(listed_reservations.last).must_equal @reservation2
    end
  end

  # describe 'reservation_cost method' do
  #   it 'finds the cost of a given reservation' do
  #     found_reservation = hotel.find_reservation(@reservation)
  #     cost2 = hotel.reservation_cost(@reservation2)
  #
  #     expect(cost).must_equal 200
  #     expect(cost2).must_equal 600
  #   end
  # end
end
