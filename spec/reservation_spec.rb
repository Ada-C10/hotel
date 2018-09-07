require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/Reservation'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "Reservation" do

  # TODO: test end date AFTER start date
  # TODO: test cost as float?
  # TODO: test id as any pos int
  # TODO: test room_num as 1-20
  # TODO: test cost nil or 200 or other value
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
  end

  describe "#dates_reserved" do
    # TODO: test edge cases like same start/end date
    # TODO: error handling for bad start/end dates (above?)
    it "returns an array of Date objects" do
      expect(reservation.dates_reserved).must_be_kind_of Array
      expect(reservation.dates_reserved[0]).must_be_kind_of Date
    end
    it "can list all the dates of a reservation" do
      expect(reservation.dates_reserved.length).must_equal 3

      date1_s = reservation.dates_reserved[0].strftime('%Y %b %d')
      date2_s = reservation.dates_reserved[1].strftime('%Y %b %d')
      date3_s = reservation.dates_reserved[2].strftime('%Y %b %d')

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
