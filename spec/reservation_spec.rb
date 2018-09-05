require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/Reservation'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "Reservation" do
  # QUESTION: needed for creation: id, room_num, date_start, date_end, cost=200
  # ^^ keyword args? hash input??
  # TODO: test end date AFTER start date
  # TODO: test cost as float?
  # TODO: test id as any pos int
  # TODO: test room_num as 1-20
  # QUESTION: let vs before/do --> preference and use case diff?
  let(:start_date) {Date.new(2004, 7, 1)}
  let(:end_date) {Date.new(2004, 7, 4)}
  let(:reservation) {Hotel::Reservation.new(2, 3, start_date, end_date)}

  describe "#initialize" do
    it "can create a new instance of reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
      expect(reservation.id).must_equal 2
    end
  end

# TODO: go back to this after figuring out all other tests
  # describe "#dates_reserved" do
  #   # TODO: test edge cases like same start/end date
  #   # TODO: error handling for bad start/end dates (above?)
  #   it "returns an array of Date objects" do
  #
  #     expect(reservation.dates_reserved).must_be_kind_of Array
  #     expect(reservation.dates_reserved()[0]).must_be_kind_of Date
  #
  #     second_start_date = ("2004, 7, 2")
  #     second_end_date = ("2004, 7, 3")
  #     expect(reservation.dates_reserved[1]).must_equal second_date
  #   end
  #   it "can list all the dates of a reservation" do
  #     expect(reservation.dates_reserved.length).must_equal 3
  #
  #     second_date = Date.new(2004, 7, 2)
  #     expect(reservation.dates_reserved[1]).must_equal second_date
  #   end
  # end
end
