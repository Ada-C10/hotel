require_relative 'spec_helper'

describe 'DateRange Class' do
    let (:date_range) { Hotel::DateRange.new('2018-09-01', '2018-09-05') }

  describe 'Initializer' do
    it 'Creates an instance of DateRange' do
      expect(date_range).must_be_kind_of Hotel::DateRange
    end

  describe "check_valid_dates method" do
    it 'Raises an ArgumentError for invalid date ranges' do

      expect{
        date_range.check_valid_dates('2018-09-05', '2018-09-01')
      }.must_raise ArgumentError

      expect{
        date_range.check_valid_dates('', '2018-09-01')
      }.must_raise ArgumentError

      expect{
        date_range.check_valid_dates('2018-09-01', '')
      }.must_raise ArgumentError

      expect{
        date_range.check_valid_dates('', '')
      }.must_raise ArgumentError

    end
  end

  describe 'dates_overlap? method' do
    it 'overlaps if both date range are the same' do
      expect(date_range.dates_overlap?('2018-09-01', '2018-09-05')).must_equal true
    end

    it 'overlaps if reservation date range overlaps in the front of booked date range' do
      expect(date_range.dates_overlap?('2018-08-31', '2018-09-02')).must_equal true
    end

    it 'overlaps if reservation date range overlaps in the back of booked dates range' do
      expect(date_range.dates_overlap?('2018-09-04', '2018-09-07')).must_equal true
    end

    it 'overlaps if reservation date range are contained within the booked dates range' do
      expect(date_range.dates_overlap?('2018-09-02', '2018-09-03')).must_equal true
    end

    it 'overlaps if the reservation date range are completely containing of the booked dates range' do
      expect(date_range.dates_overlap?('2018-08-30', '2018-09-07')).must_equal true
    end

    it 'does not overlap if reservation date range are completely before the booked dates' do
      expect(date_range.dates_overlap?('2018-08-25', '2018-08-30')).must_equal false
    end

    it 'does not overlap if reservation date range are completely before the booked dates' do
      expect(date_range.dates_overlap?('2018-08-25', '2018-08-30')).must_equal false
    end

    it 'does not overlap if reservation date range are completely after the booked dates' do
      expect(date_range.dates_overlap?('2018-09-10', '2018-09-15')).must_equal false
    end

    it 'does not overlap if reservation date range ends on check-in date of booked date range' do
      expect(date_range.dates_overlap?('2018-08-30', '2018-09-01')).must_equal false
    end

    it 'does not overlap if reservation date ranges starts on check-out date of the booked date range' do
      expect(date_range.dates_overlap?('2018-08-25', '2018-08-30')).must_equal false
    end




  end






  end
end
