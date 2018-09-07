require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'spec_helper'
require_relative '../lib/booking_system'
require_relative '../lib/reservation'



describe "initialize" do
  before do
    @dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
  end

  it "is an instance of Reservation" do
    expect(@dates).must_be_kind_of Hotel::DateRange
  end

  it "Takes check_in, check_out" do
    expect(@dates).must_respond_to :check_in
    expect(@dates).must_respond_to :check_out
  end

  it "raises a StandardError if check-out is before check-in " do

    expect {Hotel::reservation.new(check_in, check_out)}.must_raise StandardError
  end

  it "is set up for specific attributes and data types" do
    [:check_in, :check_out].each do |initial|
      expect(@dates).must_respond_to initial
    end
    expect(@dates.check_in).must_be_kind_of Date
    expect(@dates.check_out).must_be_kind_of Date

  end

  describe "find_duration_of_stay" do
    before do
      @dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      # @dates2 = Hotel::DateRange.new("2018-04-03", "2018-04-06")
      # @dates3 = Hotel::DateRange.new("2018-06-03", "2018-06-06")
    end

    it "finds the duration of stay" do
      expect(@dates.duration_of_stay).must_equal 3
    end

    describe "find if dates are included" do
      before do
        @dates = Hotel::DateRange.new("2018-02-03", "2018-02-06")
      end
      it "finds if there are overlapping dates" do
        date_to_find = Date.parse("2018-02-04")
        reservations_by_date = @dates.included_in_date_range(date_to_find)
        expect(reservations_by_date).must_equal true
      end
    end
  end

end
