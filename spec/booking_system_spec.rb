require_relative 'spec_helper'

describe "BookingSystem class" do
  before do
    @reservation = Hotel::Reservation.new({check_in_date: 180904, check_out_date: 180907})

    @booking = Hotel::BookingSystem.new
  end

  it "create BookingSystem class" do
    expect(@booking).must_be_kind_of Hotel::BookingSystem
  end

  it "initialize method" do
    expect(@booking.booked_dates).must_be_kind_of Array
  end

  it "returns array of all room numbers in hotel" do
    expect(@booking.list_all_rooms_in_hotel).must_be_kind_of Array
    expect(@booking.list_all_rooms_in_hotel).must_equal [*1..20]
  end

  it "returns array of dates with the assigned room" do
    expect(@booking.assign_room_to_booking(@reservation)).must_be_kind_of Array
    expect(@booking.assign_room_to_booking(@reservation)).must_equal [[Date.parse("180904"), 1], [Date.parse("180905"), 1], [Date.parse("180906"), 1]]
  end

  it "returns the total cost of the booking" do
    expect(@booking.calculate_booking_cost(@reservation)).must_be_kind_of Integer
    expect(@booking.calculate_booking_cost(@reservation)).must_equal 600
  end

  xit "" do
  end
end
