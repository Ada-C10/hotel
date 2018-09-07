require_relative 'spec_helper'
# REFACTOR IDEAS:
# replace before with let inside of it, use a nested describe that way I only have to create a single let variable
#

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
    expect(reservations.length).must_equal 1
  end

  it "return the cost of a reservation" do
    #arrange
    reservation = @admin.reservations.first
    reservation_cost = @admin.find_cost(reservation)

    expect(reservation_cost).must_be_kind_of Integer
    expect(reservation_cost).must_equal 200
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

  # needs to update this test
  # before and after from driver
  it "can make a reservation" do
    start_date = "2018-08-07 00:00:00 -0700"
    end_date = "2018-08-09 00:00:00 -0700"
    range = (start_date..end_date)
    @admin.reserve_room(start_date, end_date)


    expect(@admin.booked_rooms.length).must_equal 1

  end

  it "view vacant rooms" do
    skip
    # for reserve_room
    start_date = "2018-08-07 00:00:00 -0700"
    end_date = "2018-08-09 00:00:00 -0700"
    @admin.reserve_room(start_date, end_date)
    # for range and testing view vacant_rooms
    start_time = Time.parse("2018-08-07 00:00:00 -0700")
    end_time = Time.parse("2018-08-09 00:00:00 -0700")
    range = (start_time..end_time)
    vacant_rooms_result = @admin.view_vacant_rooms(range)
    expect(vacant_rooms_result.length).must_equal 19
  end
end

describe "#range tests" do
  before do
    @admin = Admin.new
  end

  it "does not count the last day" do
    start_date = "2018-08-07 00:00:00 -0700"
    end_date = "2018-08-09 00:00:00 -0700"
    start_date = Time.parse(start_date)
    end_date = Time.parse(end_date)
    test_date = Time.parse("2018-08-09 00:00:00 -0700") # last day

    result = @admin.create_hotel_range(start_date, end_date)
    expect(result.include?(test_date)).must_equal false
  end
end
