require_relative "spec_helper"

describe "HotBook::Book class" do
  let(:hotel) { HotBook::Hotel.new }
  let(:book) { HotBook::Book.new(hotel) }
  let(:daterange) { HotBook::DateRange.new(
                    start_date: "apr_15", end_date: "apr_30") }
  let(:new_reservation) { book.new_reservation(daterange) }
  let(:load_reservations) { hotel.reservations }
  let(:block) { HotBook::Block.new(daterange, ["1", "2", "3", "4", "5"]) }
  let(:rooms) { ["1", "2", "3", "4", "5"] }
  let(:load_block) { book.new_block(daterange, rooms) }
  let(:date) {Date.parse("apr_15")}
  let(:overlaprange) { HotBook::DateRange.new( start_date: "apr_08",
                                               end_date: "apr_16") }

  before do
    book # test reservation data is loaded into @reservations
    block = load_block # a single block, rooms 1-5, 4/15-4/30, is loaded into @blocks
    block.disable("1") # This manually mimics what would happen if test reservations
    block.disable("2") # with note "This is a block (private) reservation"
    block.disable("3") # were created as block reservations
    block.disable("4")
  end

  describe "new_reservation method" do
    it "creates a Reservation object and stores in @reservations" do
      expect(new_reservation).must_be_instance_of HotBook::Reservation
      expect(book.reservations.size).must_equal 11
      3.times {book.new_reservation(daterange) }
      expect(book.reservations.size).must_equal 11 + 3
    end

    it "raises unique errors if room is booked or blocked during daterange" do
      expect{book.new_reservation(daterange, room_number: "6")}.must_raise HotBook::RoomIsTakenError
      expect{book.new_reservation(daterange, room_number: "1")}.must_raise HotBook::RoomIsBlockedError
    end
  end

  describe "suggest_room method" do
    it "returns the first publicly available room number that isn't booked or blocked" do
      expect(book.suggest_room(daterange)).must_equal "7"
    end
  end

  describe "list_by_nights method" do
    it "returns an array of reservations excluding checkout date" do
      expect(book.list_by_nights(date).size).must_equal 1
      expect(book.list_by_nights(date)[0].room_number).must_equal "6"
    end
  end

  describe "public_avail_rooms method" do
    it "returns an array of room numbers that aren't booked or blocked" do
      list = %w(7 8 9 10 11 12 13 14 15 16 17 18 19 20)
      expect(book.public_avail_rooms(overlaprange)).must_equal list
      book.new_reservation(overlaprange)
      list.shift
      expect(book.public_avail_rooms(overlaprange)).must_equal list
    end
  end

  describe "room_taken? method" do
    it "given daterange, lists rezzies with conflict, " \
    "and tells you if the given room is in that list" do
      expect(book.room_taken?(daterange, "6")).must_equal true
      expect(book.room_taken?(daterange, "1")).must_equal false
    end
  end

  describe "room_blocked? method" do
    it "given daterange, lists blocks with conflict, " \
    "and tells you if the given room is in that list" do
      expect(book.room_blocked?(daterange, "1")).must_equal true
      expect(book.room_blocked?(daterange, "6")).must_equal false
    end
  end

  describe "conflicting_reservations method" do
    it "returns an array of reservations with a daterange conflict" do
      array = book.conflicting_reservations(daterange)
      expect(array.size).must_equal 1
      expect(array[0]).must_be_instance_of HotBook::Reservation
    end
  end

  describe "conflicting_blocks method" do
    it "returns an array of blocks with a daterange conflict" do
      array = book.conflicting_blocks(daterange)
      expect(array.size).must_equal 1
      expect(array[0]).must_be_instance_of HotBook::Block
    end
  end

  describe "validate(type, var) method" do
    it "raises ArgError for invalid inputs" do
      bad_range = nil
      bad_room_number = nil
      bad_date = nil
      bad_rooms = []
      another_bad_rooms = nil
      bad_block = nil
      expect{book.new_reservation(bad_range)}.must_raise ArgumentError
      expect{book.new_reservation(daterange, room_number: bad_room_number)}.must_raise ArgumentError
      expect{book.list_by_nights(bad_date)}.must_raise ArgumentError
      expect{book.new_block(daterange, bad_rooms)}.must_raise ArgumentError
      expect{book.new_block(daterange, another_bad_rooms)}.must_raise ArgumentError
      expect{book.new_block_reservation(bad_block, room_number: "2")}.must_raise ArgumentError
    end
  end
end
