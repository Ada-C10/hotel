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
  let(:start_date) {Time.new(2004, 7, 1)}
  let(:end_date) {Time.new(2004, 7, 4)}
  let(:reservation) {Hotel::Reservation.new(2, 3, start_date, end_date)}

  describe "#initialize"
    it "can create a new instance of reservation" do
      expect(reservation).must_be_kind_of Hotel::Reservation
      expect(reservation.id).must_equal 2
    end
  end
end
