require_relative 'spec_helper'

describe "Reservation Class" do
  let (:date1) { Date.parse('2018-09-05') }
  let (:date2) { Date.parse('2018-09-07') }
  let (:date_range) { Hotel::DateRange.new(date1, date2) }
  let (:reservation) { Hotel::Reservation.new(1, date_range) }

  describe "Reservation initiation" do

    it "is an instance of Reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "has a DateRange as an argument" do
      expect(reservation.date_range).must_be_kind_of Hotel::DateRange
      expect(reservation.date_range.check_in).must_be_kind_of Date
      expect(reservation.date_range.check_out).must_be_kind_of Date

    end
  end

  describe "calculate_total_cost helper method" do
    it "calculates the cost of the reservation " do
      date3 = Date.parse('2018-09-06')
      date4 = Date.parse('2018-12-06')
      date_range2 = Hotel::DateRange.new(date3, date4)
      reservation_1 = Hotel::Reservation.new(1, date_range)
      reservation_2 = Hotel::Reservation.new(2, date_range2)
      expect(reservation_1.cost).must_equal 400
      expect(reservation_2.cost ).must_equal 18200
    end
  end

  # describe "assign_room method" do
  #   it "assigns Room to reservation from array of Rooms" do
  #     reservation = Hotel::Reservation.new(1, date_range)
  #     rooms = [Hotel::Room.new(1), Hotel::Room.new(2), Hotel::Room.new(3)]
  #
  #     reservation.assign_room(rooms)
  #     expect(reservation.room).must_be_kind_of Hotel::Room
  #   end
  #
  #   # it "assigns " do
  #   #   reservation.assign_room(rooms)
  #   #   expect(reservation.room).must_be_kind_of Hotel::Room
  #   # end
  # end

end
