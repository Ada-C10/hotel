require_relative 'spec_helper'
require 'pry'

describe 'Module Hotel' do
  before do
    @hotel = Hotel::Hotel.new
    @start_date = Date.parse("1/9/2018")
    @end_date = Date.parse("5/9/2018")
  end

  it 'returns an instance of a room' do
    room = Hotel::Room.new(1)
    expect(room).must_be_kind_of Hotel::Room
  end

  it 'returns array of room number from 1-20' do
    room_numbers = @hotel.get_all_numbers
    expect(room_numbers).must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  end

  it 'returns an random available room' do
    room_num = @hotel.get_available_room(@start_date, @end_date)
    expect(room_num).must_equal 1
  end

  #Date.parse format: Date.parse("10/5/2018"), 10 is day, 5 is month

  it 'assigns_a_reservation give start_date and end_date' do
    reservation = @hotel.assigns_a_reservation(@start_date, @end_date)
    expect(reservation).must_be_kind_of Hotel::Reservation
end


end












# describe 'booking_system' do
#   it 'returns an instance of a BookingSystem' do
#     list = BookingSystem.new("10/10/2018", "10/12/2018", 4)
#     expect(list).must_be_kind_of BookingSystem
#   end
# end
#
#
# describe 'booking_system' do
#   it 'the first room instance should equal 1 for room 1' do
#     list = BookingSystem.new("10/10/2018", "10/12/2018", 4)
#     expect(list.hotel_instances[0].room).must_equal 1
#   end
# end


# describe 'booking_system' do
#   it "Give you the list of the reservation if it is avilable" do
#
#   start_time = 1/9/2018
#   end_time = 3/9/2018
#   room = 3
#
#   one_reservation = Reservation.new(start_time, end_time, room).Room.new(room).availability(start_time, end_time)
#
#   expect(one_reservation).must_be_kind_of Array
# end
# end
