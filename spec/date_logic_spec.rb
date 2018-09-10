require_relative 'spec_helper.rb'

describe 'Wave 1' do
  describe 'DateLogic.date_range_include?' do
    before do
      @hotel = BookingLogic::RoomBooker.new

      room_id1 = 14
      check_in1 = Date.new(2018, 4, 1)
      check_out1 = Date.new(2018, 4, 2)
      @reservation1 = @hotel.new_reservation(room_id1, check_in1, check_out1)

      room_id2 = 15
      check_in2 = Date.new(2018, 4, 3)
      check_out2 = Date.new(2018, 4, 6)
      @reservation2 = @hotel.new_reservation(room_id2, check_in2, check_out2)
    end

    it 'returns true when reservation date range includes given date' do
      result = DateLogic.date_range_include?(@reservation1, Date.new(2018, 4, 1))
      expect(result).must_equal true

      result2 = DateLogic.date_range_include?(@reservation2, Date.new(2018, 4, 4))
      expect(result2).must_equal true
    end

    it 'returns false when reservation date range does not include given date' do
      result = DateLogic.date_range_include?(@reservation1, Date.new(2018, 4, 2))
      expect(result).must_equal false

      result2 = DateLogic.date_range_include?(@reservation2, Date.new(1992, 9, 11))
      expect(result2).must_equal false

      result3 = DateLogic.date_range_include?(@reservation2, Date.new(2018, 4, 6))
      expect(result3).must_equal false
    end
  end
end

describe 'Wave 2' do
  describe 'DateLogic.date_range_exclusive?' do
    it 'returns true for completely non-intersecting date ranges' do
      non_intersecting = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 3),
        Date.new(2018, 4, 4),
        Date.new(2018, 4, 18))

      non_intersecting2 = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 3, 1),
        Date.new(2018, 3, 16),
        Date.new(2018, 2, 3),
        Date.new(2018, 2, 28))

      expect(non_intersecting).must_equal true
      expect(non_intersecting2).must_equal true
    end

    it 'returns false for back intersecting dates' do
      intersecting = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 3),
        Date.new(2018, 4, 2),
        Date.new(2018, 4, 18))

      expect(intersecting).must_equal false
    end

    it 'returns false for front intersecting dates' do
      intersecting = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 5),
        Date.new(2018, 4, 4),
        Date.new(2018, 4, 18))

      expect(intersecting).must_equal false
    end

    it 'returns false for encapsulated dates' do
      encapsulated1 = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 21),
        Date.new(2018, 4, 4),
        Date.new(2018, 4, 18))

      encapsulated2 = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 3),
        Date.new(2018, 3, 2),
        Date.new(2018, 4, 18))

      expect(encapsulated1).must_equal false
      expect(encapsulated2).must_equal false
    end

    it 'returns false for same dates' do
      same_dates = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 3),
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 3))

      expect(same_dates).must_equal false
    end

    it 'returns true when reservations end/begin on checkout date' do
      first_checkout = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 3),
        Date.new(2018, 4, 3),
        Date.new(2018, 4, 18))

      second_checkout = DateLogic.date_ranges_exclusive?(
        Date.new(2018, 4, 1),
        Date.new(2018, 4, 3),
        Date.new(2018, 3, 27),
        Date.new(2018, 4, 1))

      expect(first_checkout).must_equal true
      expect(second_checkout).must_equal true
    end
  end
end
