require_relative 'spec_helper'
<<<<<<< HEAD
# require_relative '../lib/hotel_admin.rb'
=======
require_relative '../lib/hotel_admin.rb'
>>>>>>> 7ad404c6cf9267bef449cee230493c6008ca966b


describe 'Admin Class' do
  describe 'initialize Admin' do
    it 'it is an instance of Admin' do
      @test_admin = Hotel::Admin.new
      expect(@test_admin).must_be_kind_of Hotel::Admin
    end
  end

<<<<<<< HEAD
it 'reserves a room for a specific date' do
  @new_reservation = Hotel::New_Reservation.new_reservation.new
  expect(@new_reservation).must_be_kind_of Hotel::Reservation
end

=======
>>>>>>> 7ad404c6cf9267bef449cee230493c6008ca966b
  it 'creates a list of twenty rooms' do
    @rooms = Hotel::Room.create_rooms
    expect(@rooms.length).must_equal 20
  end

<<<<<<< HEAD
  it 'can check the status of a room' do
    @test_room = Hotel::Admin.new
    expect(@test_room.check_room_status).must_equal Unavailable
  end
  it 'creates a reservation' do
    test_reservation = Hotel::Admin.create_reservation.new( '09/20/18', '09/22/18', 1)
    expect(test_reservation).must_be_kind_of Reservation::ReserveRoom
  end
=======
  # it 'can check the status of a room' do
  #   @test_room = Hotel::Admin.new
  #   expect(@test_room.check_room_status).must_equal Unavailable
  # end
  # it 'creates a reservation' do
  #   test_reservation = Hotel::Admin.create_reservation.new( '09/20/18', '09/22/18', 1)
  #   expect(test_reservation).must_be_kind_of Reservation::ReserveRoom
  # end
>>>>>>> 7ad404c6cf9267bef449cee230493c6008ca966b
end
