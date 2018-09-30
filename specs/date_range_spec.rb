require_relative 'spec_helper'

describe 'DateRange Class' do
  describe 'initialize date_range' do
    it 'is an instance of date_range' do
      test_date_range = DateRange.new('09/20/18', '09/22/18')
      expect(test_date_range).must_be_kind_of DateRange
    end
  end
end
