require_relative "spec_helper"

describe "HotBook::DateRange class" do
  let(:daterange) {
    HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_2") }

  describe "initialize method" do
    it "accepts Strings as args" do
      expect(daterange.start_date).must_equal Date.parse("apr_1")
    end

    it "accepts Date objects as args" do
      date1 = Date.parse("apr_1_00")
      date2 = Date.parse("apr_6_00")
      daterange = HotBook::DateRange.new(start_date: date1, end_date: date2)
    end

    it "start_date and end_date instance vars are Date class objects" do
      expect(daterange.start_date).must_be_instance_of Date
    end

    it "correctly raises a StandardError if end !>= start" do
      end_dates = ["apr_6", "apr_1"]
      end_dates.each do |end_date|
        expect{HotBook::DateRange.new(start_date: "apr_6",
                                      end_date: end_date)
              }.must_raise StandardError
      end
    end

    it "works with Time.to_date, including case T2>T1 but same date" do
      time1 = Time.now # today
      time2 = time1 + 60 # (arbitrary) 1 minute later today
      date1 = time1.to_date
      date2 = time2.to_date
      expect{HotBook::DateRange.new(start_date: date1, end_date: date2)
            }.must_raise StandardError
    end

    it "handles edge cases for both 1 nil arg AND 2 nil args" do # might break if I raise errors elsewhere
      expect{HotBook::DateRange.new(start_date: nil, end_date: nil)
            }.must_raise StandardError
      expect{HotBook::DateRange.new(start_date: nil, end_date: "apr_1")
            }.must_raise StandardError
      expect{HotBook::DateRange.new(start_date: "apr_1", end_date: nil)
            }.must_raise StandardError
    end
  end

  describe "duration method" do
    it "correctly sums total NIGHTS of the stay, even for a one night stay" do
      daterange = HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_2")
      expect(daterange.duration).must_equal 1
    end
  end
  #
  # describe "is_valid? method" do
  #   it "returns true for valid range" do
  #     expect(daterange.is_valid?).must_equal true
  #   end
  #   it "raises ArgError for invalid range" do
  #   end
  # end

  describe "conflict? method" do
    range1 = HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_10")
    # check these new ranges against range1:
    noconflict1 = HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_6")
    noconflict2 = HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_3")
    noconflict3 = HotBook::DateRange.new(start_date: "apr_10", end_date: "apr_30")
    noconflict4 = HotBook::DateRange.new(start_date: "apr_11", end_date: "apr_30")
    conflict1= HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_7")
    conflict2 = HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_7")
    conflict3= HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_10")
    conflict4 = HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_12")
    conflict5 = HotBook::DateRange.new(start_date: "apr_7", end_date: "apr_10")
    conflict6 = HotBook::DateRange.new(start_date: "apr_7", end_date: "apr_30")

    it "will return false if ranges don't conflict" do
      expect(range1.conflict?(noconflict1)).must_equal false
      expect(range1.conflict?(noconflict2)).must_equal false
      expect(range1.conflict?(noconflict3)).must_equal false
      expect(range1.conflict?(noconflict4)).must_equal false
    end

    it "will return true if ranges do conflict" do
      expect(range1.conflict?(conflict1)).must_equal true
      expect(range1.conflict?(conflict2)).must_equal true
      expect(range1.conflict?(conflict3)).must_equal true
      expect(range1.conflict?(conflict4)).must_equal true
      expect(range1.conflict?(conflict5)).must_equal true
      expect(range1.conflict?(conflict6)).must_equal true
    end

    it "will work in reverse" do
      expect(noconflict1.conflict?(range1)).must_equal false
      expect(noconflict2.conflict?(range1)).must_equal false
      expect(noconflict3.conflict?(range1)).must_equal false
      expect(noconflict4.conflict?(range1)).must_equal false
      expect(conflict1.conflict?(range1)).must_equal true
      expect(conflict2.conflict?(range1)).must_equal true
      expect(conflict3.conflict?(range1)).must_equal true
      expect(conflict4.conflict?(range1)).must_equal true
      expect(conflict5.conflict?(range1)).must_equal true
      expect(conflict6.conflict?(range1)).must_equal true
    end
  end

  describe "to_range method" do
    it "will return a Range class object" do
      range = daterange.to_range
      expect(range).must_be_instance_of Range
    end

    it "correctly allows a res end and another res start on the same day" do
      date = Date.parse("apr_2")
      range = daterange.to_range
      expect(range.include? date).must_equal false
    end
  end

end
