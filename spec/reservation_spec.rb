require_relative "spec_helper"

describe "HotBook::Reservation class" do
  let(:daterange) { HotBook::DateRange.new(start_date: "apr_6",
                                           end_date: "apr_8") }
  let(:reservation) { HotBook::Reservation.new(daterange: daterange,
                                               room_number: "one",
                                               room_rate: 1.0) }

  describe "initialize method" do
    it "will correctly calculate duration" do
      expect(reservation.duration).must_equal 2
    end

    it "will correctly accept room_number" do
      expect(reservation.room_number).must_equal "one"
    end

    it "will correctly accept room_rate" do
      expect(reservation.room_rate).must_equal 1.0
    end

    it "will raise NoMethodError if daterange doesn't respond to duration" do
      badrange = "some_string"
      expect{
        HotBook::Reservation.new(daterange: badrange,
                                 room_number: "one",
                                 room_rate: 0.0) }.must_raise NoMethodError
    end
  end

  describe "cost method" do
    it "will return correct cost" do
      expect(reservation.cost).must_equal 2.0
    end
  end

end
