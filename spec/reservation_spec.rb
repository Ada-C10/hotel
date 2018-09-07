require_relative "spec_helper"

# the Reservation class is all about dates.
# specifically, the start and end date passed in to it

describe "HotBook::Reservation class" do
  let(:args) {{start_date: "18/12/1", end_date: "18/12/3"}}
  let(:reservation) {HotBook::Reservation.new(args)}
  invalid_args = {start_date: "18/12/3", end_date: "18/12/1"}
  let(:bad_reservation) {HotBook::Reservation.new(invalid_args)}
  another_invalid_args = {start_date: "18/12/1", end_date: "18/12/1"}
  let(:another_bad_reservation) {HotBook::Reservation.new(another_invalid_args)}

  describe "initialize arguments" do
    it "will parse any date you throw at it" do
    end

    it "raises StandardError for end date == or < start date" do
      expect{bad_reservation}.must_raise StandardError
      expect{another_bad_reservation}.must_raise StandardError
    end

    it "raises ArgumentError for nil or empty or non-Date class" do
      tests = []
      tests << missing_args = {start_date: "", end_date: "18/12/3"}
      tests << more_missing_args = {end_date: "18/12/3"}
      tests << bad_args = {start_date: :rumplestiltskin, end_date: "18/12/3"}
      tests << more_bad_args = {start_date: [[3]], end_date: "18/12/3"}
      tests.each do |args|
        expect{HotBook::Reservation.new(args)}.must_raise ArgumentError
      end
    end
  end

  describe "duration" do
    it "calculates duration correctly" do
      expect(reservation.duration).must_equal 2
    end
  end


end

# @start_date
# @end_date
# defer how the reservations and rooms are linked!
# calculate duration
# standard error if date range is invalid
