require_relative 'spec_helper'

# runs from project directory
describe "#Admin - initializer" do
  before do
    @admin = Admin.new
  end
  it "is an instance of Admin" do
    dispatcher = Admin.new
    expect(dispatcher).must_be_kind_of Admin
  end

  it "accurately loads reservation information into reservations array" do
    first_reservation = @admin.reservations.first
    last_reservation = @admin.reservations.last

    expect(first_reservation.start_time).must_equal Time.parse("2018-08-08 00:00:00 -0700")
    expect(first_reservation.end_time).must_equal Time.parse("2018-08-09 00:00:00 -0700")
    expect(first_reservation.nights).must_equal 1
    expect(first_reservation.cost).must_equal 200
    expect(first_reservation.id).must_equal 1

    expect(last_reservation.start_time).must_equal Time.parse("2018-08-07 00:00:00 -0700")
    expect(last_reservation.end_time).must_equal Time.parse("2018-08-09 00:00:00 -0700")
    expect(last_reservation.nights).must_equal 2
    expect(last_reservation.cost).must_equal 400
    expect(last_reservation.id).must_equal 2
  end

  xdescribe "#find reservation" do
    it "return the reservations that have a spicific date" do
      skip
      reservations = Reservation.find(Time.parse("2016-08-08"))

      expect(reservations).must_be_kind_of Array
      expect(first.start_time).must_equal Time.parse("2016-08-08")
    end
  end
end
