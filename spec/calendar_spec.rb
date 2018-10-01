require_relative 'spec_helper'

describe "Calendar" do
  let(:cal) {Hotel::Calendar.new(check_in: "1986-07-20", check_out: "1986-07-29")}

  describe "#initialize" do
    it "can create a new instance of Calendar" do
      expect(cal).must_be_kind_of Hotel::Calendar
    end

    it "correctly loads date attributes" do
      expect(cal.check_in).must_be_kind_of Date
      expect(cal.check_in.strftime('%Y %b %d')).must_equal "1986 Jul 20"

      expect(cal.check_out).must_be_kind_of Date
      expect(cal.check_out.strftime('%Y %b %d')).must_equal "1986 Jul 29"
    end

    it "throws a StandardError if fed improper date format for start or end date" do
      expect {
        Hotel::Calendar.new(
          check_in: "2009,7,2",
          check_out: "2009-7-1"
          )}.must_raise StandardError

          expect {
            Hotel::Calendar.new({
              check_in: "2009-7-2",
              check_out: "2009,7,1"
              })}.must_raise StandardError
            end

            it "throws a StandardError if end date occurs before or on same day as start date" do
              expect {
                Hotel::Calendar.new({
                  check_in: "2009-7-2",
                  check_out: "2009-7-1"
                  })}.must_raise StandardError

                  expect {
                    Hotel::Calendar.new({
                      check_in: "2009-7-1",
                      check_out: "2009-7-1"
                      })}.must_raise StandardError
                    end
                  end

                  describe "#has_date?" do
                    it "returns true if other date is between check in and check out dates: in the middle" do
                      other_date = "1986-07-25"

                      has_date = cal.has_date?(other_date)

                      expect(has_date).must_equal true
                    end

                    it "returns true if other date is between check in and check out dates: on check in date" do
                      other_date = "1986-07-20"

                      has_date = cal.has_date?(other_date)

                      expect(has_date).must_equal true
                    end

                    it "returns true if other date is between check in and check out dates: on day before check out" do
                      other_date = "1986-07-28"

                      has_date = cal.has_date?(other_date)

                      expect(has_date).must_equal true
                    end

                    it "returns false if other date is outside of check in and check out dates: before check in date" do
                      other_date = "1986-07-15"

                      has_date = cal.has_date?(other_date)

                      expect(has_date).must_equal false
                    end

                    it "returns false if other date is outside of check in and check out dates: after check out date" do
                      other_date = "1986-07-31"

                      has_date = cal.has_date?(other_date)

                      expect(has_date).must_equal false
                    end

                    it "returns false if other date is outside of check in and check out dates: on check out date" do
                      # edge case
                      other_date = "1986-07-29"

                      has_date = cal.has_date?(other_date)

                      expect(has_date).must_equal false
                    end
                  end

                  describe "#overlap?" do
                    it "returns false for no overlap: other dates begin and end before reserved dates" do
                      other_dates = Hotel::Calendar.new(check_in: "1986-07-01", check_out: "1986-07-15")

                      dates_overlap = cal.overlap?(other_dates)

                      expect(dates_overlap).must_equal false
                    end

                    it "returns false for no overlap: other dates begin and end after reserved dates" do
                      other_dates = Hotel::Calendar.new(check_in: "1986-07-30", check_out: "1986-07-31")

                      dates_overlap = cal.overlap?(other_dates)

                      expect(dates_overlap).must_equal false
                    end

                    it "returns false for no overlap: other dates begin during reserved dates' check out date" do
                      # edge case
                      other_dates = Hotel::Calendar.new(check_in: "1986-07-29", check_out: "1986-07-31")

                      dates_overlap = cal.overlap?(other_dates)

                      expect(dates_overlap).must_equal false
                    end

                    it "returns false for no overlap: other dates end during reserved dates' check in date" do
                      # edge case
                      other_dates = Hotel::Calendar.new(check_in: "1986-07-15", check_out: "1986-07-20")

                      dates_overlap = cal.overlap?(other_dates)

                      expect(dates_overlap).must_equal false
                    end

                    it "returns true if dates overlap: other dates begin and end beyond reserved dates range" do
                      other_dates = Hotel::Calendar.new(check_in: "1986-07-01", check_out: "1986-07-31")

                      dates_overlap = cal.overlap?(other_dates)

                      expect(dates_overlap).must_equal true
                    end

                    it "returns true if dates overlap: other dates are fully contained within reserved dates" do
                      other_dates = Hotel::Calendar.new(check_in: "1986-07-25", check_out: "1986-07-28")

                      dates_overlap = cal.overlap?(other_dates)

                      expect(dates_overlap).must_equal true
                    end

                    it "returns true if dates overlap: other dates begin before but end during reserved dates" do
                      other_dates = Hotel::Calendar.new(check_in: "1986-07-10", check_out: "1986-07-28")

                      dates_overlap = cal.overlap?(other_dates)

                      expect(dates_overlap).must_equal true
                    end

                    it "returns true if dates overlap: other dates begin during but end after reserved dates" do
                      other_dates = Hotel::Calendar.new(check_in: "1986-07-25", check_out: "1986-07-31")

                      dates_overlap = cal.overlap?(other_dates)

                      expect(dates_overlap).must_equal true
                    end
                  end

                  describe "#nights_reserved" do
                    it "returns the number of nights reserved" do
                      num_nights = cal.check_out - cal.check_in
                      expect(num_nights).must_equal 9
                    end
                  end
                end
