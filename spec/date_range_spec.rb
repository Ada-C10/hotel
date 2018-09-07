require_relative 'spec_helper'

describe 'DateRange class' do

  describe 'DateRange instantiation' do
    let (:today) { Date.today }
    let (:today_plus_2) { today + 2}
    let (:today_minus_2) {today - 2}
    let (:range) { Hotel::DateRange.new(today, today_plus_2) }
    # before do
    #   today = Date.today
    #   today_plus_2 = @check_in + 2
    # end

    it 'creates an instance of DateRange' do
      expect(Hotel::DateRange.new(today, today_plus_2)).must_be_instance_of Hotel::DateRange

      expect(Hotel::DateRange.new(today, today_plus_2)).must_respond_to :check_in

      expect(Hotel::DateRange.new(today, today_plus_2)).must_respond_to :check_out
    end

    it 'raises an Argument error if end date is before the start date' do
      expect{
        Hotel::DateRange.new(today, today_minus_2)
      }.must_raise ArgumentError
    end

    it 'raises an Argument error if given anything besides a Date object' do
      expect{
        Hotel::DateRange.new("2000-10-10", today_minus_2)
      }.must_raise ArgumentError
      expect{
        Hotel::DateRange.new(today, 20001010)
      }.must_raise ArgumentError
    end

    describe 'get_total_days method' do
      it 'returns the number of days in the date range' do
        check_in = Date.new(2020, 1, 1)
        check_out = check_in + 2
        range = Hotel::DateRange.new(check_in, check_out)
        expect(range.get_total_days).must_equal 2
      end
    end

    describe 'is_within_date_range' do
      it 'returns true if date is within the range' do
        expect(range.is_within_date_range(Date.today)).must_equal true
      end

      it 'returns false if date is outside the range' do
        expect(range.is_within_date_range(Date.today - 1)).must_equal false
      end

      it 'returns false if given an invalid date' do
        expect(range.is_within_date_range('Not a Date')).must_equal false
      end
    end
  end
end
