require 'pry'
require_relative 'spec_helper'

describe "Admin class" do
  before do
    @admin_1 = Admin.new
  end

  describe "Initializer" do
    it "is an instance of Admin" do
      expect(@admin_1).must_be_kind_of Admin
    end

    it "establishes the base data structures when instantiated" do
      # binding.pry
      expect(@admin_1.reservations).must_be_kind_of Array
      expect(@admin_1.rooms).must_be_kind_of Array
    end
  end

  # describe "make_reservation" do
  #
  #   it "will add a reservation object to Reservation array" do
  #       reservation_made = @admin.make_reservation()
  #       driven_trips = trip_generated.room.driven_trips
  #
  #       expect(driven_trips).must_include trip_generated
  #   end
  #
  #
  #   it "will add the  object to passenger's trips array" do
  #     trip_generated = @dispatcher.request_trip(1)
  #     trips = trip_generated.passenger.trips
  #
  #     expect(trips).must_include trip_generated
  #   end
  #
  #   it "will add the trip object to the collection of all trips in trip dispatcher" do
  #     all_trips = @dispatcher.trips
  #     trip_count = all_trips.length
  #     trip_generated = @dispatcher.request_trip(1)
  #
  #     expect(all_trips).must_include trip_generated
  #     expect(all_trips.length).must_equal trip_count + 1
  #
  #   end
  #
  #   it "will change the driver status to unavailabe" do
  #     trip_generated = @dispatcher.request_trip(1)
  #     status = trip_generated.driver.status
  #
  #     expect(status).must_equal :UNAVAILABLE
  #
  #   end
  #
  #   it "will return the trip" do
  #     trip_generated = @dispatcher.request_trip(1)
  #
  #     expect(trip_generated).must_be_kind_of RideShare::Trip
  #
  #   end
  #
  #   it "will return a message when no driver is available for trip" do
  #     @dispatcher.drivers.each do |driver|
  #       driver.status = :UNAVAILABLE
  #     end
  #
  #     expect(@dispatcher.request_trip(6)).must_equal "No driver available at this time."
  #   end
  #
  #   it "will not create a trip if no driver is available" do
  #     @dispatcher.drivers.each do |driver|
  #       driver.status = :UNAVAILABLE
  #     end
  #     trip_count = @dispatcher.trips.length
  #     @dispatcher.request_trip(6)
  #
  #     expect(@dispatcher.trips.length).must_equal trip_count
  #
  #   end
  #
  # end

  # describe "list_reservations on a specific date" do
  #   it "returns an array of reservations" do
  #     expect
  #
  # end

  # describe "find_room method" do
  #   before do
  #     @admin = Admin.new(3)
  #   end
  #
  #   it "throws an argument error for a bad ID" do
  #     expect{ @admin.find_room(0) }.must_raise ArgumentError
  #   end
  #
  #   it "finds a room instance" do
  #     room_found = @admin.find_room(2)
  #     expect(passenger).must_be_kind_of Room
  #   end
  # end

end
