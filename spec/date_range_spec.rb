require_relative 'spec_helper'

describe 'DateRange Class' do
  before do
    @date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
    @reservation_1 = Hotel::BookingSystem.new()
    @reservation_1.make_reservation(@date_range_1)
  end

  let (:date_range_2) { Hotel::DateRange.new('2018-09-01', '2018-09-05') }
  let (:reservation_2) {
    Hotel::BookingSystem.new().make_reservation(date_range_2)
  }

  let (:date_range_3) { Hotel::DateRange.new('2018-08-31', '2018-09-02') }
  let (:date_range_4) { Hotel::DateRange.new('2018-09-04', '2018-09-07') }
  let (:date_range_5) { Hotel::DateRange.new('2018-09-02', '2018-09-03') }
  let (:date_range_6) { Hotel::DateRange.new('2018-08-30', '2018-09-10') }

  let (:date_range_7) { Hotel::DateRange.new('2018-08-25', '2018-08-30') }
  let (:date_range_8) { Hotel::DateRange.new('2018-09-10', '2018-09-15') }
  let (:date_range_9) { Hotel::DateRange.new('2018-08-30', '2018-09-01') }
  let (:date_range_10) { Hotel::DateRange.new('2018-09-05', '2018-09-10') }

  describe 'Initializer' do
    it 'Creates an instance of DateRange' do
      expect(@date_range_1).must_be_kind_of Hotel::DateRange
    end

    it 'Stores start date and end date as date objects' do
      expect(@date_range_1.start_date).must_be_kind_of Date
      expect(@date_range_1.end_date).must_be_kind_of Date
    end
  end

  describe "check_valid_dates method" do
    it 'Raises a StandardError for invalid date ranges' do

      expect{
        @date_range_1.check_valid_dates('2018-09-05', '2018-09-01')
      }.must_raise StandardError

      expect{
        @date_range_1.check_valid_dates('', '2018-09-01')
      }.must_raise StandardError

      expect{
        @date_range_1.check_valid_dates('2018-09-01', '')
      }.must_raise StandardError

      expect{
        @date_range_1.check_valid_dates('', '')
      }.must_raise StandardError

    end
  end


  describe 'dates_overlap? method' do
    before do
      @date_range = @reservation_1.reservations[0].date_range
    end

    it 'overlaps if both date range are the same' do
      expect(date_range_2.dates_overlap?(@date_range)).must_equal true
    end

    it 'overlaps if new date range overlaps in the front of booked date range' do
      expect(date_range_3.dates_overlap?(@date_range)).must_equal true
    end

    it 'overlaps if new date range overlaps in the back of booked dates range' do
      expect(date_range_4.dates_overlap?(@date_range)).must_equal true
    end

    it 'overlaps if new date range is contained within the booked dates range' do
      expect(date_range_5.dates_overlap?(@date_range)).must_equal true
    end

    it 'overlaps if the new date range are completely containing the booked dates range' do
      expect(date_range_6.dates_overlap?((@date_range))).must_equal true
    end

    it 'does not overlap if new date range are completely before the booked dates' do
      expect(date_range_7.dates_overlap?(@date_range)).must_equal false
    end

    it 'does not overlap if new date range are completely after the booked dates' do
      expect(date_range_8.dates_overlap?(@date_range)).must_equal false
    end

    it 'does not overlap if new date range ends on check-in date of booked date range' do
      expect(date_range_9.dates_overlap?(@date_range)).must_equal false
    end

    it 'does not overlap if new date ranges starts on check-out date of the booked date range' do
      expect(date_range_10.dates_overlap?(@date_range)).must_equal false
    end
  end
  
end
