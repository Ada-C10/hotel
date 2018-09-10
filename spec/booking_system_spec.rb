require_relative 'spec_helper'
require_relative '../lib/booking_system'

describe "what the hotel booking system does" do
  before do
    @room_number = 12
    @check_in = Date.new(2018, 8, 24)
    @check_out = @check_in + 5
    @booking_system = Hotel::BookingSystem.new
  end

  it "create a class for the booking system" do
    @booking_system.must_be_kind_of Hotel::BookingSystem
  end

  it "books a new room" do
    new_reservation = @booking_system.book_room(@room_number, @check_in, @check_out)
    new_reservation.must_be_kind_of Hotel::Reservation

    @booking_system.reservations.length.must_equal 1
  end

  it "returns argument if room_number is outside range" do
    expect{ @booking_system.book_room(50, @check_in, @check_out) }.must_raise ArgumentError
  end

  it "returns all reservations" do
    @booking_system.book_room(@room_number, @check_in, @check_out)
    @booking_system.must_respond_to :reservations
    @booking_system.reservations.length.must_equal 1
  end

  it "returns all rooms" do
    @booking_system.must_respond_to :rooms
  end

  it "returns list of reservations on a given date" do
    @booking_system.reservations_on_date(@check_in).must_be_kind_of Array
  end

  it "returns a list of available rooms" do
    date_range = Hotel::DateRange.new(@check_in, @check_out)
    @booking_system.book_room(@room_number, @check_in, @check_out)
    @booking_system.available_rooms(date_range).wont_include @room_number
  end

  it "raises ArgumentError if requested room is unavailable" do
    @booking_system.book_room(@room_number, @check_in, @check_out)
    expect { @booking_system.book_room(@room_number, @check_in, @check_out) }.must_raise ArgumentError
  end

  it "allows a reservation to start on the same day that another ends" do
    @booking_system.book_room(@room_number, @check_in, @check_out)
    expect(@booking_system.book_room(@room_number, @check_out, @check_out + 1)).must_be_kind_of Hotel::Reservation
  end


end
