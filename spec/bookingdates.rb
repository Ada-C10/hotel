require_relative 'spec_helper'

# Refactoring of Hotel included addition of BookingDates class
# borrowed tests from instructor solution

describe Hotel::BookingDates do
  describe 'constructor' do
    it 'Can be initialized with two dates' do
      checkin = Date.new(2017, 01, 01)
      checkout = checkin + 3

      range = Hotel::BookingDates.new(checkin, checkout)

      range.checkin.must_equal checkin
      range.checkout.must_equal checkout
    end

    it "is an an error for negative-length ranges" do
      checkin = Date.new(2017, 01, 01)
      checkout = checkin - 3

      proc {
        Hotel::BookingDates.new(checkin, checkout)
      }.must_raise Hotel::BookingDates::InvalidBookingDatesError
    end

    it "is an error to create a 0-length range" do
      checkin = Date.new(2017, 01, 01)
      checkout = checkin

      proc {
        Hotel::BookingDates.new(checkin, checkout)
      }.must_raise Hotel::BookingDates::InvalidBookingDatesError
    end
  end

  describe 'overlaps' do
    before do
      checkin = Date.new(2017, 01, 01)
      checkout = checkin + 3

      @range = Hotel::BookingDates.new(checkin, checkout)
    end

    it "returns true for the same range" do
      checkin = @range.checkin
      checkout = @range.checkout
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal true
    end

    it "returns true for a contained range" do
      checkin = @range.checkin + 1
      checkout = @range.checkout - 1
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal true
    end

    it "returns true for a range that overlaps in front" do
      checkin = @range.checkin - 1
      checkout = @range.checkout - 1
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      checkin = @range.checkin + 1
      checkout = @range.checkout + 1
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal true
    end

    it "returns true for a containing range" do
      checkin = @range.checkin - 1
      checkout = @range.checkout + 1
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal true
    end

    it "returns false for a range starting on the checkout date" do
      checkin = @range.checkout
      checkout = @range.checkout + 3
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal false
    end

    it "returns false for a range ending on the checkin date" do
      checkin = @range.checkin - 3
      checkout = @range.checkin
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal false
    end

    it "returns false for a range completely before" do
      checkin = @range.checkin - 10
      checkout = @range.checkout - 10
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal false
    end

    it "returns false for a date completely after" do
      checkin = @range.checkin + 10
      checkout = @range.checkout + 10
      test_range = Hotel::BookingDates.new(checkin, checkout)

      @range.overlaps?(test_range).must_equal false
    end
  end

  describe 'contains' do
    before do
      checkin = Date.new(2017, 01, 01)
      checkout = checkin + 3

      @range = Hotel::BookingDates.new(checkin, checkout)
    end

    it "reutrns false if the date is clearly out" do
      @range.contains?(@range.checkin - 5).must_equal false
      @range.contains?(@range.checkout + 5).must_equal false
    end

    it "returns true for dates in the range" do
      (@range.checkin...@range.checkout).each do |date|
        @range.contains?(date).must_equal true
      end
    end

    it "returns false for the checkout date" do
      @range.contains?(@range.checkout).must_equal false
    end
  end

  describe "nights" do
    it "returns the correct number of nights" do
      nights = 3
      checkin = Date.new(2017, 01, 01)
      checkout = checkin + nights

      @range = Hotel::BookingDates.new(checkin, checkout)

      @range.nights.must_equal nights
    end
  end
end
