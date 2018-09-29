require_relative 'spec_helper'
require 'pry'

describe 'Module Hotel' do
  before do
    @hotel = Hotel::Hotel.new
    @start_date = Date.parse("1/9/2018")
    @end_date = Date.parse("5/9/2018")
    @block = @hotel.block_rooms(@start_date, @end_date, 5, "Ada")

  end

  it 'returns an instance of a room' do
    room = Hotel::Room.new(1)
    expect(room).must_be_kind_of Hotel::Room
  end

  it 'returns array of room number from 1-20' do
    room_numbers = @hotel.get_all_numbers
    expect(room_numbers).must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
  end

  it 'returns a available room' do
    room_num = @hotel.get_available_room(@start_date, @end_date)
    expect(room_num).must_be_kind_of Integer
  end



  it 'assigns_a_reservation give start_date and end_date' do
    reservation = @hotel.assigns_a_reservation(@start_date, @end_date)
    expect(reservation).must_be_kind_of Hotel::Reservation
  end

  it "returns reservation list of all the current reservations" do

    @start_date = Date.parse("1/9/2018")
    @end_date = Date.parse("5/9/2018")


    @start_date1 = Date.parse("4/9/2018")
    @end_date1 = Date.parse("6/9/2018")

    reservation1 = @hotel.assigns_a_reservation(@start_date, @end_date)

    reservation2 = @hotel.assigns_a_reservation(@start_date1, @end_date1)

    expect(@hotel.reservations).must_be_kind_of Array
    expect(reservation1).must_be_kind_of Hotel::Reservation
    expect(reservation2).must_be_kind_of Hotel::Reservation


  end

  it "return a reservation for a specific date" do
    @hotel = Hotel::Hotel.new

    match_res = @hotel.assigns_a_reservation(@start_date, @end_date)

    @start_date1 = Date.parse("4/9/2018")
    @end_date1 = Date.parse("6/9/2018")

    reservation2 = @hotel.assigns_a_reservation(@start_date1, @end_date1)

    reservations_fordate = @hotel.reservations_for_date(@start_date)

    expect(reservations_fordate).must_be_kind_of Array
    expect(reservations_fordate.length).must_equal 1
    expect(reservations_fordate.first).must_equal match_res

  end



  it "returns list of reserved room_nums for a specific
  DATE RANGE" do

  reservation1 = @hotel.assigns_a_reservation(@start_date, @end_date)

  reservations_fordates = @hotel.reserved_rooms_for_dates(@start_date, @end_date)

  expect(reservations_fordates).must_be_kind_of Array
  expect(reservation1).must_be_kind_of Hotel::Reservation
end



it "gives list of rooms that are available after some of them have been reserved" do

  reservation1 = @hotel.assigns_a_reservation(@start_date, @end_date)

  avail_rooms = @hotel.nonreserved_rooms_fordates(@start_date, @end_date)

  expect(avail_rooms).must_be_kind_of Array
  expect(reservation1).must_be_kind_of Hotel::Reservation

end

it "reserves an available room for a given date range" do

  22.times do |i|
    @hotel.assigns_a_reservation((@start_date - i), (@end_date - i))
  end

  @start_date = Date.parse("1/9/2018")
  @end_date = Date.parse("5/9/2018")

  @start_date1 = Date.parse("5/9/2018")
  @end_date1 = Date.parse("6/9/2018")

  @hotel.assigns_a_reservation(@start_date1, @end_date1)

  expect(@hotel).must_be_kind_of Hotel::Hotel
  expect(@hotel.reservations.length).must_equal 23
  expect(@hotel.reservations.class).must_equal Array


end

it "Raises an ArgumentError when all the rooms have been reserved out and there are no longer any more rooms available" do
  proc {
    22.times do |i|
      @hotel.assigns_a_reservation((@start_date - i), (@end_date + i))
    end
  }.must_raise ArgumentError

end


@hotel = Hotel::Hotel.new
@start_date = Date.parse("1/9/2018")
@end_date = Date.parse("5/9/2018")
@block = @hotel.block_rooms(@start_date, @end_date, 5, "Ada")



=begin
Hi! In Edges we talked about interesting test cases for date overlaps this afternoon. Here is a full list of all the cases I’ll be looking for when I give feedback:

Two date ranges *do* overlap if range A compared to range B:
- Same dates
- Overlaps in the front
- Overlaps in the back
- Completely contained
- Completely containing

Two date ranges are *not* overlapping if range A compared to range B:
- Completely before
- Completely after
- Ends on the checkin date
- Starts on the checkout date (edited)
=end

it " does not a return reservation that has a date that ends on a checking date " do

  start_test_date = Date.parse("10/8/2018")
  end_test_date = Date.parse("15/8/2018")

  @start_date1 = Date.parse("5/8/2018")
  @end_date1 = Date.parse("10/8/2018")
  one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
  x =  @hotel.reserved_rooms_for_dates(start_test_date, end_test_date)

  expect(x[0]).must_equal nil
end








it " does not a return reservation for a date that date is completely after " do

  start_test_date = Date.parse("10/8/2018")
  end_test_date = Date.parse("15/8/2018")

  @start_date1 = Date.parse("5/8/2018")
  @end_date1 = Date.parse("8/8/2018")
  one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
  x =  @hotel.reserved_rooms_for_dates(start_test_date, end_test_date)

  expect(x[0]).must_equal nil
end




it " does not a return reservation for a date that date is completely before " do

  start_test_date = Date.parse("10/8/2018")
  end_test_date = Date.parse("15/8/2018")

  @start_date1 = Date.parse("18/8/2018")
  @end_date1 = Date.parse("20/8/2018")
  one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
  x =  @hotel.reserved_rooms_for_dates(start_test_date, end_test_date)

  expect(x[0]).must_equal nil
end

















it "returns reservation for a date that overlaps in the front " do

  start_test_date = Date.parse("10/8/2018")
  end_test_date = Date.parse("15/8/2018")

  @start_date1 = Date.parse("13/8/2018")
  @end_date1 = Date.parse("18/8/2018")
  one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
  x =  @hotel.reserved_rooms_for_dates(start_test_date, end_test_date)

  expect(x[0]).must_equal one_reserv.room_num
end




it "returns reservation for a date that overlaps in the back" do
  start_test_date = Date.parse("10/8/2018")
  end_test_date = Date.parse("20/8/2018")

  @start_date1 = Date.parse("9/8/2018")
  @end_date1 = Date.parse("18/8/2018")
  one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
  x =  @hotel.reserved_rooms_for_dates(start_test_date, end_test_date)

  expect(x[0]).must_equal one_reserv.room_num
end




it "returns reservation for a date that is completely contained" do
  start_test_date = Date.parse("10/7/2018")
  end_test_date = Date.parse("15/7/2018")

  @start_date1 = Date.parse("9/7/2018")
  @end_date1 = Date.parse("16/7/2018")
  one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
  x =  @hotel.reserved_rooms_for_dates(start_test_date, end_test_date)

  expect(x[0]).must_equal one_reserv.room_num
end



it "returns reservation for a date that is completely contating" do
  start_test_date = Date.parse("10/7/2018")
  end_test_date = Date.parse("15/7/2018")

  @start_date1 = Date.parse("11/7/2018")
  @end_date1 = Date.parse("14/7/2018")
  one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
  x =  @hotel.reserved_rooms_for_dates(start_test_date, end_test_date)

  expect(x[0]).must_equal one_reserv.room_num
end



#
#
# @start_date1 = Date.parse("1/9/2018")
# @end_date1 = Date.parse("15/9/2018")
# one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
#
#
#
# @start_date1 = Date.parse("10/9/2018")
# @end_date1 = Date.parse("15/9/2018")
# one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
#
#
#
# @start_date1 = Date.parse("10/9/2018")
# @end_date1 = Date.parse("15/9/2018")
# one_reserv = @hotel.assigns_a_reservation(@start_date1, @end_date1)
#
#
#



















it "Return an error if more than 5 rooms are choosen for a block" do
  proc {
    @hotel.block_rooms(@start_date, @end_date, 10, "Smith")
  }.must_raise ArgumentError

end


it "Block Test, returns array of blocked rooms" do
  # @block = @hotel.block_rooms(@start_date, @end_date, 5, "Ada")

  expect(@block).must_be_kind_of Array
  expect(@block).length.must_equal 2
  expect(@block[0].name).must_equal "Ada"

end


it "reserves a block" do
  reservations = @hotel.reserve_block_room(1, "Ada")
  expect(reservations).must_be_kind_of Array
  expect(reservations[0].start_date).must_equal @start_date
  expect(reservations[0].end_date).must_equal @end_date
end



















end
