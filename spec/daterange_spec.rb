require_relative "spec_helper"

describe "HotBook::DateRange class" do
  let(:daterange) {HotBook::DateRange.new(start_date: "apr_1",
                                          end_date: "apr_2")}

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

  describe "is_after? method" do
    # existing range:
    oldrange = HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_10")
    # check these new ranges against existing range:
    ok1 = HotBook::DateRange.new(start_date: "apr_29", end_date: "apr_30")
    ok2 = HotBook::DateRange.new(start_date: "apr_10", end_date: "apr_30")
    notok1= HotBook::DateRange.new(start_date: "apr_9", end_date: "apr_30")
    notok2 = HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_6")
    notok3 = HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_5")

      it "will return true if ranges don't conflict" do
        expect(ok1.is_after?(oldrange)).must_equal true
      end

      it "allows a new range (reservation) to start on the same day" \
         "that another one ends" do
        expect(ok2.is_after?(oldrange)).must_equal true
      end

      it "will return false if ranges do conflict" do
        expect(notok1.is_after?(oldrange)).must_equal false
      end

      it "will return false if new range is before oldrange" do
        expect(notok2.is_after?(oldrange)).must_equal false
        expect(notok3.is_after?(oldrange)).must_equal false
      end

    describe "to_range method" do
      it "will return a Range class object" do
        daterange = HotBook::DateRange.new(start_date: "apr_1",
                                           end_date: "apr_2")
        range = daterange.to_range
        expect(range).must_be_instance_of Range
      end
    end
  end

end
