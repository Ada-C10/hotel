require_relative 'spec_helper'

describe "BookingSystem class" do
  # before do
  #   list = Hotel::Reservation.new
  # end

  it "rooms in hotel method" do
    list = Hotel::Reservation.new(180904, 180905)

    expect(list).must_be_kind_of Hotel::Reservation
    # expect(list.room_number).must_be_kind_of Integer
    # expect(list.room_number).must_equal 2
    expect(list.check_in_date).must_equal Date.parse("2018-09-04")
    expect(list.check_out_date).must_equal Date.parse("2018-09-05")
  end

  it "raises ArgumentError if check out date is before check in date" do
    expect{(list = Hotel::Reservation.new(180904, 180903))}.must_raise StandardError
  end

  it "calculates the number of nights the user wants to book" do
    list = Hotel::Reservation.new(180904, 180905)
    expect(list.count_number_of_nights).must_equal 1
  end



end
