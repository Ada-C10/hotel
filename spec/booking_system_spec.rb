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

  it "list all bookings of that date" do
    bad_reservation = @booking.make_reservation(check_in_date: 180909, check_out_date: 1809010)

    expect(@booking.list_reservations_by_date(180904)).must_include @reservation
    expect(@booking.list_reservations_by_date(180904)).wont_include bad_reservation
  end

  it "returns msg if more than one reservation created" do
    bad_reservation = @booking.make_reservation(check_in_date: 180909, check_out_date: 1809010)
    expect(@booking.reservations.length).must_equal 2
  end

  # it "does not create reservation if dates are booked" do
  #   bad_reservation = @booking.make_reservation(check_in_date: 180904, check_out_date: 180905)
  #
  #   expect{(@booking)}.must_raise 0
  # end
end
