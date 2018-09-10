require_relative "spec_helper"

describe "HotBook::Block class" do
  let(:rooms) { ["1","2","3"] }
  let(:daterange) {
    HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_7") }
  let(:block) {
    HotBook::Block.new(daterange: daterange,
                       rooms: rooms) }


  describe "initialize method" do
    it "will store an array of rooms" do
      expect(block.rooms).must_equal rooms
      expect(block.available).must_equal rooms
    end
    it "will store upcase room numbers" do
      rooms = ["one", "two"]
      block = HotBook::Block.new(daterange: daterange,
                                 rooms: rooms)
      expect(block.available).must_equal ["ONE", "TWO"]
    end
  end

  describe "disable method" do
    it "won't alter the rooms array when it executes" do
      block.disable("1")
      expect(block.available).must_equal ["2", "3"]
      expect(block.rooms).must_equal ["1", "2", "3"]
    end
  end

  describe "conflict? method" do
    it "will correctly return a daterange conflict" do
      conflict = HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_7")
      anotherconflict = HotBook::DateRange.new(start_date: "apr_5", end_date: "apr_8")
      noconflict = HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_6")

      expect(block.conflict?(conflict)).must_equal true
      expect(block.conflict?(anotherconflict)).must_equal true
      expect(block.conflict?(noconflict)).must_equal false
    end
  end
end
