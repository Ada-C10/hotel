require_relative 'spec_helper'


describe 'Reservation Class' do
   describe 'initialize a reservation' do
    it 'creates an instance of a reservation' do
      test_reservation = Hotel::ReserveRoom.new
      expect(test_reservation).must_be_kind_of Reservation::ReserveRoom
    end
    it 'can check the status of a new room' do
      @room = Hotel::Room.new(1)
      expect(@room.status).must_equal :Available
    end

    it 'can calculate the cost of a reservation' do
      @test_reservation = Hotel::ReserveRoom.new('09/20/18', '09/22/18')
      expect(@test_reservation.calculate_cost).must_equal 400.0
    end
  end

  it 'can check the status of a room' do
  @test_room = Reservation::ReserveRoom.new( '09/20/18', '09/22/18', 1, 200)

  expect(@test_room.check_room_status).must_equal Unavailable
  end
end
