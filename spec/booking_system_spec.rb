require_relative 'spec_helper'

describe "BookingSystem class" do
  before do
    @booking = Hotel::BookingSystem.new
    @reservation = @booking.make_reservation(check_in_date: 180904, check_out_date: 180907)
  end

  it "create BookingSystem class" do
    expect(@booking).must_be_kind_of Hotel::BookingSystem
  end

  it "initialize method" do
    expect(@booking.reservations).must_be_kind_of Array
  end

  it "returns array of all room numbers in hotel" do
    expect(@booking.list_all_rooms).must_be_kind_of Array
    expect(@booking.list_all_rooms).must_equal [*1..20]
  end

  it "returns array of dates" do
    expect(@reservation).must_be_kind_of Hotel::Reservation
    expect(@reservation.date_range).must_equal [Date.parse("180904"), Date.parse("180905"), Date.parse("180906")]
  end

  it "returns the total cost of the booking" do
    expect(@reservation.calculate_booking_cost).must_equal 600
  end

  it "books a reservation that starts at the checkout date of another reservation" do
    new_reservation = @booking.make_reservation(check_in_date: 180907, check_out_date: 180908)
    expect(@booking.reservations.length).must_equal 2
  end

  it "list all bookings of that includes that date" do
    bad_reservation = @booking.make_reservation(check_in_date: 180909, check_out_date: 180910)
    new_reservation = @booking.make_reservation(check_in_date: 180904, check_out_date: 180906)
    fourth_reservation = @booking.make_reservation(check_in_date: 180903, check_out_date: 180906)

    expect(@booking.reservations.length).must_equal 4
    expect(@booking.list_reservations_by_date(180904)).must_include @reservation
    expect(@booking.list_reservations_by_date(180904)).wont_include bad_reservation
    expect(@booking.list_reservations_by_date(180904).length).must_equal 3
  end

  it "accepts reservations that aren't overlapping in dates with other bookings" do
    new_reservation = @booking.make_reservation(check_in_date: 180909, check_out_date: 1809010)
    another_booking = @booking.make_reservation(check_in_date: 180909, check_out_date: 180910)

    expect(@booking.reservations.length).must_equal 3
  end

  # it "does not create reservation if dates are booked" do
  #
  #   expect{ @booking.make_reservation(check_in_date: 180904, check_out_date: 180906) }.must_raise ArgumentError
  # end
end
