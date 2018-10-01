require_relative 'spec_helper'
require 'pry'

describe "Reservation" do
  describe "Initializes an instance of reservation and its instance methods" do
    before do
    @hotel_ada = Hotel::ReservationManager.new(20)
    @new_reservation = @hotel_ada.reserve_room("2018-08-23", "2018-08-25")
    @test_reservation = @hotel_ada.reserve_room("2018-09-18", "2018-09-20")
    end

    it "creates an instance of Reservation" do
      expect(@test_reservation).must_be_instance_of Hotel::Reservation
      expect(@test_reservation.rooms).must_be_kind_of Array
      expect(@test_reservation.check_in).must_be_instance_of Date
      expect(@test_reservation.check_in.day).must_equal 18
      expect(@test_reservation.date_range.count).must_equal 2
    end

    it "checks to see if there are any reservations for a given date" do
      expect(@test_reservation.find_reservation("2018-09-19")).must_equal true
    end

    it "calulates total cost for a reservation" do
#binding.pry
      expect(@test_reservation.total_cost).must_equal 400
    end
  end
end
