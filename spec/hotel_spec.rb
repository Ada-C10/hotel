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

  it 'returns a available room' do
    room_num = @hotel.get_available_room(@start_date, @end_date)
    expect(room_num).must_equal 1
  end

  #Date.parse format: Date.parse("10/5/2018"), 10 is day, 5 is month

  it "raises an argument error for invalid dates" do
    #proc catches the error when .assigns_a_reservation is invoked
    proc {
      @hotel.assigns_a_reservation(@end_date, @start_date)
    }.must_raise ArgumentError
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

    match_res = @hotel.assigns_a_reservation(@start_date, @end_date)

    @start_date1 = Date.parse("4/9/2018")
    @end_date1 = Date.parse("6/9/2018")

    # nomatch_res = (warning: assigned but unused variable - nomatch_res so commented it out)
    @hotel.assigns_a_reservation(@start_date1, @end_date1)

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
  expect(reservations_fordates[0]).must_equal 1
end



it "gives list of rooms that are available after some of them have been reserved" do

  reservation1 = @hotel.assigns_a_reservation(@start_date, @end_date)

  avail_rooms = @hotel.nonreserved_rooms_fordates(@start_date, @end_date)

  expect(avail_rooms).must_be_kind_of Array
  expect(reservation1).must_be_kind_of Hotel::Reservation
  expect(avail_rooms).must_equal [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

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
end


describe 'Module Hotel' do
  before do
    @hotel = Hotel::Hotel.new
    @start_date = Date.parse("1/9/2018")
    @end_date = Date.parse("5/9/2018")
  end

  it "creates a a Block" do
    rand_num = rand(1..5)
    reservation = @hotel.reserve_block_rooms(@start_date, @end_date, rand_num)

    expect(reservation).must_be_kind_of Array
    expect(reservation.length).must_equal rand_num

  end
end
