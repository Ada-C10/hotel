require_relative 'spec_helper'

describe "Reservation Class" do

  describe "Reservation initiation" do
    let (:reservation) { Hotel::Reservation.new(1, '2018-09-05', '2018-09-07') }

    it "is an instance of Reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "has two Dates as arguments " do
      expect(reservation.check_in).must_be_kind_of Date
      expect(reservation.check_out).must_be_kind_of Date
    end
  end

  describe "calculate_total_cost helper method" do
    it "calculates the cost of the reservation " do
      reservation_1 = Hotel::Reservation.new(1, '2018-09-05', '2018-09-07')
      reservation_2 = Hotel::Reservation.new(2, '2018-09-06', '2018-12-06')
      expect(reservation_1.cost).must_equal 400
      expect(reservation_2.cost ).must_equal 18200
    end
  end

  describe "assign_room method" do
    it "assigns Room to reservation from array of Rooms" do
      reservation = Hotel::Reservation.new(1, '2018-09-05', '2018-09-07')
      rooms = [Hotel::Room.new(1), Hotel::Room.new(2), Hotel::Room.new(3)]

      reservation.assign_room(rooms)
      expect(reservation.room).must_be_kind_of Hotel::Room
    end

    # it "assigns " do
    #   reservation.assign_room(rooms)
    #   expect(reservation.room).must_be_kind_of Hotel::Room
    # end
  end

end
