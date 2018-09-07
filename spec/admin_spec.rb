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

  it "accurately create_rooms" do
    first_room = @admin.rooms.first
    last_room = @admin.rooms.last
    expect(first_room.number).must_equal 1
    expect(last_room.number).must_equal 20
  end
end

describe "#reservation information" do
  before do
    @admin = Admin.new
  end
  it "return the reservations that have a specific date as a start date" do
    #arrange
    date = "2018-08-07 00:00:00 -0700"

    reservations = @admin.find_reservations(date)

    expect(reservations).must_be_kind_of Array
    expect(reservations.first.id).must_equal 2
  end

  it "return the cost of a reservation" do
    #arrange
    reservation_id = 2

    reservation_cost = @admin.find_cost(reservation_id)

    expect(reservation_cost).must_be_kind_of Integer
    expect(reservation_cost).must_equal 400
  end

end

describe "#rooms information" do
  before do
    @admin = Admin.new
  end
  it "view all of the rooms" do

    rooms = @admin.view_all_rooms
    expect(rooms).must_be_kind_of Array
  end

  it "can make a reservation" do
    start_date = "2018-08-07 00:00:00 -0700"
    end_date = "2018-08-09 00:00:00 -0700"
    range = (start_date..end_date)
    @admin.reserve_room(start_date, end_date) # change status of room

    rooms = @admin.view_all_rooms

    expect(rooms.first.ranges).include?(range)
  end
end
