# require 'date'

require_relative 'spec_helper'

describe 'DateRange class' do

  describe 'DateRange instantiation' do
    before do
      @start_date = Date.new(2020, 1, 1)
      @end_date = @start_date + 2
    end

    it 'creates an instance of DateRange' do
      expect(Hotel::DateRange.new(@start_date, @end_date)).must_be_instance_of Hotel::DateRange
    end

    # # possibly unnecessary
    # it 'raises an error if either input argument is ""' do
    #   expect{DateRange.new()}.must_raise StandardError
    # end

    it 'raises an Argument error if end date is before the start date' do
      expect{
        Hotel::DateRange.new(@start_date, @start_date - 2)
      }.must_raise ArgumentError
    end

    it 'raises an Argument error is input dates have past' do
      old_start = Date.new(2000, 1, 1)

      expect{
        Hotel::DateRange.new(old_start, old_start + 2)
      }.must_raise ArgumentError
    end

  end
end
