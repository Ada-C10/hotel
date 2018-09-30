require_relative 'spec_helper'


describe 'Reservation Class' do
   describe 'initialize a reservation' do
    it 'creates an instance of a reservation' do
<<<<<<< HEAD
      test_reservation = Hotel::ReserveRoom.new
=======
      test_reservation = Reservation::ReserveRoom.new( '09/20/18', '09/22/18', 1)
>>>>>>> 7ad404c6cf9267bef449cee230493c6008ca966b
      expect(test_reservation).must_be_kind_of Reservation::ReserveRoom
    end
    it 'can check the status of a new room' do
      @room = Hotel::Room.new(1)
      expect(@room.status).must_equal :Available
    end

    it 'can calculate the cost of a reservation' do
<<<<<<< HEAD
      @test_reservation = Hotel::ReserveRoom.new('09/20/18', '09/22/18')
=======
      @test_reservation = Reservation::ReserveRoom.new( '09/20/18', '09/22/18', 12)

>>>>>>> 7ad404c6cf9267bef449cee230493c6008ca966b
      expect(@test_reservation.calculate_cost).must_equal 400.0
    end
  end

<<<<<<< HEAD
  it 'can check the status of a room' do
  @test_room = Reservation::ReserveRoom.new( '09/20/18', '09/22/18', 1, 200)

  expect(@test_room.check_room_status).must_equal Unavailable
  end
=======
  # it 'can check the status of a room' do
  # @test_room = Reservation::ReserveRoom.new( '09/20/18', '09/22/18', 1, 200)
  # binding.pry
  # expect(@test_room.check_room_status).must_equal Unavailable
  # end
>>>>>>> 7ad404c6cf9267bef449cee230493c6008ca966b
end
