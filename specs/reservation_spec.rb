require_relative 'spec_helper'
# require_relative '../lib/reservation'

describe 'Reservation Class' do
   describe 'initialize a reservation' do
    it 'creates an instance of a reservation' do
      test_reservation = Reservation::ReserveRoom.new( '09/20/18', '09/22/18', 1)
      expect(test_reservation).must_be_kind_of Reservation::ReserveRoom
    end
    it 'can check the status of a new room' do
      @room = Hotel::Room.new(1)
      expect(@room.status).must_equal :Available
    end

    it 'can calculate the cost of a reservation' do
      @test_reservation = Reservation::ReserveRoom.new( '09/20/18', '09/22/18', 1, 200)
      expect(@test_reservation.calculate_cost).must_equal 400.0
    end
  end

  # (start_date_time, end_date_time, room_number, room_status)
  #   @start_date_time = start_date_time
  #   @end_date_time = end_date_time
  #   @room_number = room_number
  #   if room_status == :Available
  #     room_status = :Unavailable
  #   end
  # it 'can see a list of reservations for a specific date' do
  #
  # end
end
