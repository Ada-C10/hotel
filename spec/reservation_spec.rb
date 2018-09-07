require_relative 'spec_helper'

describe "Reservation" do

  # TODO: test id as any pos int?
  # TODO: test room_num as 1-20?

  let(:reservation) {Hotel::Reservation.new({
    id: "2",
    room_num: "3",
    check_in: "2004-7-1",
    check_out: "2004-7-4"})}

  describe "#initialize" do
    it "can create a new instance of reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
      expect(reservation.id).must_equal 2
    end

    it "throws a StandardError if fed improper date format for check_in or check_out" do
    expect {
      Hotel::Reservation.new({
        id: "5",
        room_num: "8",
        check_in: "2009,7,2",
        check_out: "2009-7-1"
        })}.must_raise StandardError

    expect {
      Hotel::Reservation.new({
        id: "5",
        room_num: "8",
        check_in: "2009-7-2",
        check_out: "2009,7,1"
        })}.must_raise StandardError
    end

    it "throws a StandardError if check_out occurs before or on same day as check_in" do
    expect {
      Hotel::Reservation.new({
        id: "5",
        room_num: "8",
        check_in: "2009-7-2",
        check_out: "2009-7-1"
        })}.must_raise StandardError

    expect {
      Hotel::Reservation.new({
        id: "5",
        room_num: "8",
        check_in: "2009-7-1",
        check_out: "2009-7-1"
        })}.must_raise StandardError
    end

    it "can create a reservation with a one-night stay" do
      # edge case
      one_night_stay = Hotel::Reservation.new({
        id: "66",
        room_num: "19",
        check_in:"2009-7-29",
        check_out: "2009-7-30"})
      expect(one_night_stay).must_be_kind_of Hotel::Reservation
      expect(one_night_stay.id).must_equal 66
    end

    it "sets daily rate to default value if no value given" do
      typical_room = Hotel::Reservation.new({
      id: "66",
      room_num: "19",
      check_in:"2009-7-29",
      check_out: "2009-7-30"})

      expect(typical_room.daily_rate).must_equal 200
    end

    # QUESTION: do we need error handling for numeric value for daily_rate?
    it "can override default value for daily rate" do
    rare_room = Hotel::Reservation.new({
      id: "66",
      room_num: "19",
      check_in:"2009-7-29",
      check_out: "2009-7-30",
      daily_rate: 500})

      expect(rare_room.daily_rate).must_equal 500
    end
  end

  describe "#dates_reserved" do
    it "returns an array of Date objects" do
      expect(reservation.dates_reserved).must_be_kind_of Array
      expect(reservation.dates_reserved[0]).must_be_kind_of Date
    end

    it "can list all the dates of a reservation" do
      date1_s = reservation.dates_reserved[0].strftime('%Y %b %d')
      date2_s = reservation.dates_reserved[1].strftime('%Y %b %d')
      date3_s = reservation.dates_reserved[2].strftime('%Y %b %d')

      expect(reservation.dates_reserved.length).must_equal 3
      expect(date1_s).must_equal "2004 Jul 01"
      expect(date2_s).must_equal "2004 Jul 02"
      expect(date3_s).must_equal "2004 Jul 03"
    end
  end

  describe "#total_stay_cost" do
    it "correctly calculates total cost for a reservation" do
      rate = 200
      dates = 3
      correct_cost = rate * dates

      expect(reservation.total_stay_cost).must_equal 600
    end
  end
end
