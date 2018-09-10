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

  describe 'reservation_cost method' do
    it 'finds the cost of a given reservation' do
      reservation1 = @reservation1.reservation_cost
      reservation2 = @reservation2.reservation_cost

      expect(reservation1).must_equal 200
      expect(reservation2).must_equal 600
    end
  end
end
