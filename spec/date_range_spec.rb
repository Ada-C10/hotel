require 'date'

require_relative 'spec_helper'

describe 'DateRange class' do
  describe 'DateRange instantiation' do
    it 'creates an instance of DateRange' do
      start_date = Date.new(2000, 1, 1)
      end_date = start_date + 2
      expect(DateRange.new(start_date, end_date)).must_be_instance_of DateRange
    end
  end
end
