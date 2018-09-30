require_relative 'spec_helper'

describe "BookingSystem class" do
  before do
    @booking = Hotel::BookingSystem.new
    @reservation = @booking.make_reservation(check_in_date: 180904, check_out_date: 180907)
  end

  it "creates a BookingSystem class" do
    expect(@booking).must_be_kind_of Hotel::BookingSystem
  end

  it "returns an array of all instances of reservations created" do
    expect(@booking.reservations).must_be_kind_of Array
    expect(@booking.reservations[0]).must_be_kind_of Hotel::ReservationCreator
  end

  it "returns array of all room numbers in hotel" do
    expect(@booking.list_all_rooms).must_be_kind_of Array
    expect(@booking.list_all_rooms).must_equal [*1..20]
  end

  it "returns array of dates" do
    expect(@reservation).must_be_kind_of Hotel::ReservationCreator
    expect(@reservation.date_range).must_equal [Date.parse("180904"), Date.parse("180905"), Date.parse("180906")]
  end

  it "returns the total cost of the booking" do
    expect(@reservation.calculate_booking_cost).must_equal 600
  end

  it "lists all bookings of specific date" do
    bad_reservation = @booking.make_reservation(check_in_date: 180909, check_out_date: 1809010)

    expect(@booking.list_reservations_by_date(180904)).must_include @reservation
    expect(@booking.list_reservations_by_date(180904)).wont_include bad_reservation
  end

  it "assigns different room number if room number is already taken for existing reservation" do
    sec_reservation = @booking.make_reservation(check_in_date: 180904, check_out_date: 180905)
    third_reservation = @booking.make_reservation(check_in_date: 180904, check_out_date: 180905)
    fourth_reservation = @booking.make_reservation(check_in_date: 180904, check_out_date: 180905)

    expect(fourth_reservation.room_number).must_equal 4
    expect(@booking.list_reservations_by_date(180904)).must_include fourth_reservation
  end

  it "raises argument error when tries to overbook" do
    19.times do
      @booking.make_reservation(check_in_date: 180904, check_out_date: 180905)
    end

    expect{(@booking.make_reservation(check_in_date: 180904, check_out_date: 180905))}.must_raise ArgumentError
  end

  it "does not raise error when booking for 20th time on same day" do
    19.times do
      @booking.make_reservation(check_in_date: 180904, check_out_date: 180905)
    end

    expect(@booking.list_reservations_by_date(180904).length).must_equal 20
  end

  it "automatically assigns room number 1 if it\'s the first booking for that date range" do
    new_reservation = @booking.make_reservation(check_in_date: 180910, check_out_date: 180911)

    expect(new_reservation.room_number).must_equal 1
    expect(@booking.reservations.length).must_equal 2
  end

  it "assigns different room number if dates overlap at the front" do
    new_reservation = @booking.make_reservation(check_in_date: 180903, check_out_date: 180905)

    expect(new_reservation.room_number).must_equal 2
    expect(@booking.reservations.length).must_equal 2
  end

  it "assigns different room number if dates overlap at the end" do
    new_reservation = @booking.make_reservation(check_in_date: 180906, check_out_date: 180908)

    expect(new_reservation.room_number).must_equal 2
    expect(@booking.reservations.length).must_equal 2
  end

  it "assigns different room number if dates are contained in existing reservation date_range" do
    new_reservation = @booking.make_reservation(check_in_date: 180905, check_out_date: 180906)

    expect(new_reservation.room_number).must_equal 2
    expect(@booking.reservations.length).must_equal 2
  end

  it "assigns different room number if dates contain the  existing reservation date_range" do
    new_reservation = @booking.make_reservation(check_in_date: 180903, check_out_date: 180908)

    expect(new_reservation.room_number).must_equal 2
    expect(@booking.reservations.length).must_equal 2
  end

  it "creates reservation for checkout date of existing reservation" do
    new_reservation = @booking.make_reservation(check_in_date: 180907, check_out_date: 180908)

    expect(new_reservation.room_number).must_equal 1
    expect(@booking.reservations.length).must_equal 2
  end

  it "creates new reservation with the same checkout date  for the checkin date of existing reservation" do
    new_reservation = @booking.make_reservation(check_in_date: 180903, check_out_date: 180904)

    expect(new_reservation.room_number).must_equal 1
    expect(@booking.reservations.length).must_equal 2
  end
end
