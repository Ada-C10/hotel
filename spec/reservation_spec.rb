require_relative "spec_helper"

## Project Requirement: User can reserve a room for a given date range
describe "HotBook::Reservation class" do
  let(:daterange) { HotBook::DateRange.new(start_date: "apr_6",
                                           end_date: "apr_8") }
  let(:reservation) { HotBook::Reservation.new(daterange: daterange,
                                               room_number: "one",
                                               room_rate: 1.0) }
  let(:load_reservations) { HotBook::Reservation.from_csv(TEST_RESERVATION_FILENAME) }
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
  end

  describe "range method" do
    it "range only includes overnights and excludes checkout day" do
      range = load_reservations[0].range
      checkout_date = Date.parse("apr_6")
      expect(range).must_be_instance_of Range
      expect(range.include? checkout_date).must_equal false
    end
  end

  describe "cost method" do
    it "will return correct cost" do
      expect(reservation.cost).must_equal 2.0
    end
  end

  describe "conflict? method" do
    it "will correctly determine if there's a daterange conflict" do
      thisres = load_reservations[1]
      thatres = load_reservations[3]
      anotherres = load_reservations[4]
      expect(thisres.conflict?(thatres)).must_equal false
      expect(thisres.conflict?(anotherres)).must_equal true
    end
  end

  describe "csv loading" do
    it "will correctly load lines of the CSV" do
      blocknote = "This is a block 1 reservation"
      expect(load_reservations[5].room_number).must_equal "1"
      expect(load_reservations.last.notes).must_equal blocknote
      expect(load_reservations.first.daterange.start_date).must_equal Date.parse("apr_1")
    end
  end

end
