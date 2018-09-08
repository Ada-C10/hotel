require_relative "spec_helper"
require "csv"
TEST_FILENAME = "support/test_reservation.csv"

# First, overwrite the test CSV
CSV.open(TEST_FILENAME, "w") #["start date", "end date", "room number", "room rate"] }
# Next, initialize a new Reservation, which stores itself in the CSV along with
# a header row
daterange = HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_8")
HotBook::Reservation.new(daterange: daterange, room_number: "before tests",
                         room_rate: 1.0, filename: TEST_FILENAME)

## Project Requirement: User can reserve a room for a given date range
describe "HotBook::Reservation class" do
  let(:daterange) { HotBook::DateRange.new(start_date: "apr_6",
                                           end_date: "apr_8") }
  let(:reservation) { HotBook::Reservation.new(daterange: daterange,
                                               room_number: "one",
                                               room_rate: 1.0,
                                               filename: TEST_FILENAME) }

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

### Project Requirement: Code should raise StandardError when an invalid
### DateRange is provided

##### Project Requirement: User can get the total cost for a given reservation
#### The last day of a reservation is the checkout day, so the guest should not
#### be charged for that night
  describe "cost method" do
    it "will return correct cost" do
      expect(reservation.cost).must_equal 2.0
    end
  end

  describe "save_reservation method" do
    it "will add itself to CSV upon initialization" do
      before_data = CSV.open(TEST_FILENAME).map { |line| line }
      HotBook::Reservation.new(daterange: daterange,
                               room_number: "thisisanewroom",
                               room_rate: 99.99,
                               filename: TEST_FILENAME)
      after_data = CSV.open(TEST_FILENAME).map { |line| line }
      expect(after_data.size).must_equal (before_data.size + 1)
      expect(after_data.last).must_equal ["2018-04-06", "2018-04-08",
                                          "thisisanewroom","99.99"]
    end
  end

end
