# require 'date'

require_relative 'spec_helper'

describe 'DateRange class' do

  describe 'DateRange instantiation' do
    before do
      @check_in = Date.new(2020, 1, 1)
      @check_out = @check_in + 2
    end

    it 'creates an instance of DateRange' do
      expect(Hotel::DateRange.new(@check_in, @check_out)).must_be_instance_of Hotel::DateRange
    end

    # # possibly unnecessary
    # it 'raises an error if either input argument is ""' do
    #   expect{DateRange.new()}.must_raise StandardError
    # end

    it 'raises an Argument error if end date is before the start date' do
      expect{
        Hotel::DateRange.new(@check_in, @check_in - 2)
      }.must_raise ArgumentError
    end

    it 'raises an Argument error is input dates have past' do
      old_start = Date.new(2000, 1, 1)

      expect{
        Hotel::DateRange.new(old_start, old_start + 2)
      }.must_raise ArgumentError
    end
  end

  describe 'get_total_days method' do
    it 'returns the number of days in the date range' do
      check_in = Date.new(2020, 1, 1)
      check_out = check_in + 2
      range = Hotel::DateRange.new(check_in, check_out)
      expect(range.get_total_days).must_equal 2
    end
  end
end
