require_relative "spec_helper"
require "csv"
# TEST_FILENAME = "support/test_reservation.csv"

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

  # describe "save_reservation method" do
  #   it "will add itself to CSV upon initialization" do
  #     before_data = CSV.open(TEST_FILENAME).map { |line| line }
  #     note_string = "This is the test Reservation"
  #     HotBook::Reservation.new(daterange: daterange,
  #                              room_number: "one",
  #                              room_rate: 1.0,
  #                              notes: note_string)
  #     after_data = CSV.open(TEST_FILENAME).map { |line| line }
  #     expect(after_data.size).must_equal (before_data.size + 1)
  #     expect(after_data.last[4]).must_equal note_string
  #   end
  # end

  # describe "self.all" do
  #   it "will return an array of hashes" do
  #     p HotBook::Reservation.all(TEST_FILENAME)
  #   end
  # end

end
