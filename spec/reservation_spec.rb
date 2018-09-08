require_relative 'spec_helper'

describe "Reservation class" do
  before do
    @start_date = Date.today
    @end_date = Date.today + 5
    @date_range = Hotel::DateRange.new(@start_date, @end_date)

    @reservation_data = {
      id: 8,
      room: 1,
      date_range: @date_range
    }

    @reservation = Hotel::Reservation.new(@reservation_data)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "#calculate_cost method" do
    it "calculates the total with the rate per nights stayed if there is no block_id" do
      total_nights_stayed = @date_range.find_num_nights
      expect(@reservation.calculate_cost).must_be_kind_of Numeric
      expect(@reservation.calculate_cost).must_equal RATE * total_nights_stayed
    end

    it "calculates the total with the rate per nights stayed if there is a block_id" do
      reservation_data = {
        id: 8,
        block_id: 4,
        room: 1,
        date_range: @date_range
      }

      reservation = Hotel::Reservation.new(reservation_data)

      total_nights_stayed = @date_range.find_num_nights
      expect(reservation.calculate_cost).must_be_kind_of Numeric
      expect(reservation.calculate_cost).must_equal RATE * BLOCK_DISCOUNT * total_nights_stayed
    end
  end
end
