require_relative 'spec_helper'

describe "Reservation" do

  let(:reservation) {Hotel::Reservation.new(
    id: "2",
    room_num: "3",
    check_in: "2004-7-1",
    check_out: "2004-7-4")}

  describe "#initialize" do
    it "can create a new instance of reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "correctly loads the initialized datatypes" do
      expect(reservation.id).must_be_kind_of Integer
      expect(reservation.room_num).must_be_kind_of Integer
      expect(reservation.daily_rate).must_be_kind_of Float
    end

    it "can create a reservation with a one-night stay" do
      # edge case
      one_night_stay = Hotel::Reservation.new(
        id: "66",
        room_num: "19",
        check_in:"2009-7-29",
        check_out: "2009-7-30")
      expect(one_night_stay).must_be_kind_of Hotel::Reservation
      expect(one_night_stay.id).must_equal 66
    end

    it "sets daily rate to default value if no value given" do
      typical_room = Hotel::Reservation.new(
      id: "66",
      room_num: "19",
      check_in:"2009-7-29",
      check_out: "2009-7-30")

      expect(typical_room.daily_rate).must_equal 200
    end

    it "can override default value for daily rate" do
    rare_room = Hotel::Reservation.new(
      id: "66",
      room_num: "19",
      check_in:"2009-7-29",
      check_out: "2009-7-30",
      daily_rate: 500)

      expect(rare_room.daily_rate).must_equal 500
    end
  end

  describe "#total_stay_cost" do
    it "correctly calculates total cost for a reservation" do
      rate = reservation.daily_rate
      dates = 3
      correct_cost = rate * dates

      expect(reservation.total_stay_cost).must_equal 600
    end
  end
end
