require_relative 'spec_helper'

describe "BookingSystem class" do
  before do
    @booking = Hotel::BookingSystem.new
  end

  it "create BookingSystem class" do
    expect(@booking).must_be_kind_of Hotel::BookingSystem
  end

  it "initialize method" do
    expect(@booking.reservations).must_be_kind_of Hash
  end

  it "any rooms should return true when no reservations" do
    expect(@booking.any_rooms(180904)).must_equal true
  end

  it "any rooms should return true when only 1 reservation" do
    @booking.reserve_room(180904, 1)
    expect(@booking.any_rooms(180904)).must_equal true
  end

  it "returns false if room is taken for that date" do
    numbers = [*1..20]

    numbers.each do |num|
      @booking.reserve_room(180904, num)
      num += 1
    end

    expect(@booking.any_rooms(180904)).must_equal false
  end

  it "returns true when no reservation" do

    check_in_date = 180904
    check_out_date = 180905
    result = @booking.can_make_reservation(check_in_date: check_in_date, check_out_date: check_out_date)
    expect(result).must_equal true
  end

  it "returns first room number when no other reservations" do
    result = @booking.automatically_reserve_and_return_room_number(180904)

    expect(result).must_equal 1
  end

  it "returns next available room number" do
    @booking.reserve_room(180904, 1)
    result = @booking.automatically_reserve_and_return_room_number(180904)

    expect(result).must_equal 2
  end

  it "raises argument error when all rooms are booked" do
    numbers = [*1..20]

    numbers.each do |num|
      @booking.reserve_room(180904, num)
      num += 1
    end

    expect{(@booking.automatically_reserve_and_return_room_number(180904))}.must_raise ArgumentError
  end

  it "return empty array when no rooms are reserved" do
    expect(@booking.show_reserved_rooms(180904)).must_equal []
  end

  it "return an array with one room when one room is reserved" do
    @booking.reserve_room(180904, 1)

    expect(@booking.show_reserved_rooms(180904).length).must_equal 1
    expect(@booking.show_reserved_rooms(180904)).must_equal [1]
  end

  it "return an array of rooms that are available on all days" do
    @booking.reserve_room(180904, 1)
    # @booking.reserve_room(180905, 1)

    result = @booking.show_available_rooms_in_range(check_in_date: 180904, check_out_date: 180905)
    expect(result).must_equal [*2..20]
  end

  it "return an empty array if no rooms available on all days" do
    room_number = [*1..20].each do |num|
      @booking.reserve_room(180904, num)
      num += 1
    end


    result = @booking.show_available_rooms_in_range(check_in_date: 180904, check_out_date: 180905)
    expect(result).must_equal []
  end

  it "return array of available rooms when we reserve it in the date range" do
    @booking.reserve_room_for_date_range(check_in_date: 180904, check_out_date: 180905)

    result = @booking.show_available_rooms_in_range(check_in_date: 180904, check_out_date: 180905)
    expect(result.length).must_equal 19
    expect(result).must_equal [*2..20]
  end

  it "return empty array when we reserve it in the date range" do
    20.times do
      @booking.reserve_room_for_date_range(check_in_date: 180904, check_out_date: 180905)
    end

    result = @booking.show_available_rooms_in_range(check_in_date: 180904, check_out_date: 180905)
    expect(result).must_equal []
  end

  it "raises argument error when try to overbook" do
    20.times do
      @booking.reserve_room_for_date_range(check_in_date: 180904, check_out_date: 180905)
    end


    expect{(@booking.reserve_room_for_date_range(check_in_date: 180904, check_out_date: 180905))}.must_raise ArgumentError
  end

  it "returns array of all room numbers in hotel" do
    expect(@booking.list_all_rooms).must_be_kind_of Array
    expect(@booking.list_all_rooms).must_equal [*1..20]
  end

  it "returns booked rooms of that specific date" do
    @booking.reserve_room_for_date_range(check_in_date: 180904, check_out_date: 180906)
    @booking.reserve_room_for_date_range(check_in_date: 180904, check_out_date: 180906)
    @booking.reserve_room_for_date_range(check_in_date: 180904, check_out_date: 180906)

    expect(@booking.list_reservations_by_date(180904)).must_be_kind_of Array
    expect(@booking.list_reservations_by_date(180904)[2]).must_be_kind_of Hotel::ReservationCreator
    expect(@booking.list_reservations_by_date(180904).length).must_equal 3
  end
end
