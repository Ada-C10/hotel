require_relative 'spec_helper'

describe 'daterange class' do

  before do
    @range = Hotel::DateRange.new(Date.new(2018,9,7), Date.new(2018,9,17))
  end

  describe 'initializing a daterange' do

    it 'returns daterange object given correct inputs' do

      expect( @range ).must_be_instance_of(Hotel::DateRange)

    end

    it 'raise ArgumentError if nondate input' do
      expect{
        Hotel::DateRange.new(Date.new(2018,5,2), 'a')
      }.must_raise(ArgumentError)
    end

    it 'raise StandardError if after date is prior to before date' do
      expect{
        Hotel::DateRange.new(Date.new(2018,5,2), Date.new(2018,5,1))
      }.must_raise(StandardError)
    end

    it 'raise StandardError if start date is same as end date' do
      expect{
        Hotel::DateRange.new(Date.new(2018,5,2), Date.new(2018,5,2))
      }.must_raise(StandardError)
    end
  end

  describe 'total nights method' do
    it 'calculates total nights' do
      expect(@range.total_nights).must_equal(10)
    end
  end

  describe 'valid date method' do
    it 'returns true if valid date is within daterange' do
      expect( @range.valid_date?(Date.new(2018,9,7)) ).must_equal(true)
      expect( @range.valid_date?(Date.new(2018,9,10)) ).must_equal(true)
      expect( @range.valid_date?(Date.new(2018,9,16)) ).must_equal(true)
    end

    it 'returns false if valid date is not within daterange' do
      expect( @range.valid_date?(Date.new(2018,9,1)) ).must_equal(false)
      expect( @range.valid_date?(Date.new(2018,9,17)) ).must_equal(false)
      expect( @range.valid_date?(Date.new(2018,9,30)) ).must_equal(false)
    end
  end

  describe 'valid daterange method' do

    it 'returns true if valid date is within daterange' do
      expect( @range.valid_daterange?(Date.new(2018,9,8),Date.new(2018,9,13)) ).must_equal(true)
      expect( @range.valid_daterange?(Date.new(2018,9,1),Date.new(2018,9,8)) ).must_equal(true)
      expect( @range.valid_daterange?(Date.new(2018,9,15),Date.new(2018,9,30)) ).must_equal(true)
      expect( @range.valid_daterange?(Date.new(2018,9,1),Date.new(2018,9,30)) ).must_equal(true)
    end

    it 'returns false if valid date is not within daterange' do
      expect( @range.valid_daterange?(Date.new(2018,8,5),Date.new(2018,9,6)) ).must_equal(false)
      expect( @range.valid_daterange?(Date.new(2018,9,17),Date.new(2018,9,18)) ).must_equal(false)
    end

  end

end
