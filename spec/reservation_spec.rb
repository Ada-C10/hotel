require_relative "spec_helper"
require "csv"
TEST_RESERVATION_FILENAME = "support/test_reservation_data.csv"

# # First, overwrite the test CSV
# CSV.open(TEST_FILENAME, "w") #["start date", "end date", "room number", "room rate"] }
# # Next, initialize a new Reservation, which stores itself in the CSV along with
# # a header row
# daterange = HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_8")
# note_string = "This Reservation is instantiated above the spec tests"
# HotBook::Reservation.new(daterange: daterange, room_number: "one",
#                          room_rate: 1.0, notes: note_string)

## Project Requirement: User can reserve a room for a given date range
describe "HotBook::Reservation class" do
  let(:daterange) { HotBook::DateRange.new(start_date: "apr_6",
                                           end_date: "apr_8") }
  let(:reservation) { HotBook::Reservation.new(daterange: daterange,
                                               room_number: "one",
                                               room_rate: 1.0) }
  describe "initialize method" do
    it "will correctly calculate duration" do
      expect(reservation.duration).must_equal 2
    end

    it "will correctly accept room_number" do
      expect(reservation.room_number).must_equal "one"
    end

    it "will correctly accept room_rate" do
      expect(reservation.room_rate).must_equal 1.0
    end
  end

  describe "cost method" do
    it "will return correct cost" do
      expect(reservation.cost).must_equal 2.0
    end
  end

  describe "csv loading" do
    it "will correctly load lines of the CSV" do
      blocknote = "This is a block 1 reservation"
      reservations = HotBook::Reservation.from_csv(TEST_RESERVATION_FILENAME)
      expect(reservations[5].room_number).must_equal "1"
      expect(reservations.last.notes).must_equal blocknote
      expect(reservations.first.daterange.start_date).must_equal Date.parse("apr_1")
    end
  end

end
