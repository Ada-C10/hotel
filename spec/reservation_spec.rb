require_relative 'spec_helper'

describe "#initialize" do
  before do
    @reservation = Reservation.new(start_time: Time.parse("2016-08-08"), end_time: Time.parse("2016-08-09"))
  end

  it "is an instance of a reservation" do
    expect(@reservation).must_be_kind_of Reservation
  end

  it "calculate number of nights" do
    expect(@reservation.nights).must_equal 1
  end

  it "calculate cost" do
    expect(@reservation.cost).must_equal 200
  end

  it "raises an Standard error for invalid date range, end time before start time" do
    @reservation = {start_time: Time.parse("2016-08-09"), end_time: Time.parse("2016-08-08")}
    expect{
        Reservation.new(@reservation)
    }.must_raise StandardError
  end
end

xdescribe "#add reservation" do
  before do
    @reservation1 = Reservation.new(start_time: Time.parse("2016-08-08"), end_time: Time.parse("2016-08-09"))
    @reservation2 = Reservation.new(start_time: Time.parse("2016-08-08"), end_time: Time.parse("2016-08-09"))
    @@reservations = [@reservation1, @reservation2]
    reservation = Reservation.new(@reservation1)
  end

  it "Increases the number of collection" do
    before_count = reservation.count
    @reservation1.add_reservation
    expected_count = before_count + 1
    expect(reservation.reservations.count).must_equal expected_count
  end

  it "Is added to the collection of reservations" do
    skip
    order = Order.new(1337, products, customer)

    order.add_product("sandwich", 4.25)
    expect(order.products.include?("sandwich")).must_equal true
  end

  it "Raises an ArgumentError if the reservation is already present" do
    skip
    order = Order.new(1337, products, customer)
    before_total = order.total

    expect {
      order.add_product("banana", 4.25)
    }.must_raise ArgumentError

    # The list of products should not have been modified
    expect(order.total).must_equal before_total
  end
end

xdescribe "#find reservation" do
  it "return the reservations that have a spicific date" do
    skip
    reservations = Reservation.find(Time.parse("2016-08-08"))

    expect(reservations).must_be_kind_of Array
    expect(first.start_time).must_equal Time.parse("2016-08-08")
  end
end


  #
