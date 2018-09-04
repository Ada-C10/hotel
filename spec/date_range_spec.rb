require 'date'

require_relative 'spec_helper'

describe 'DateRange class' do

  describe 'DateRange instantiation' do
    before do
      @start_date = Date.new(2000, 1, 1)
      @end_date = @start_date + 2
    end

    it 'creates an instance of DateRange' do
      expect(DateRange.new(@start_date, @end_date)).must_be_instance_of DateRange
    end

    # # possibly unnecessary
    # it 'raises an error if either input argument is ""' do
    #   expect{DateRange.new()}.must_raise StandardError
    # end

    it 'raises an Argument error if given invalid date range' do
      expect{
        DateRange.new(@start_date, @start_date - 2)
      }.must_raise ArgumentError
    end

  end
end
