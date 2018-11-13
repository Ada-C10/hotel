require_relative "spec_helper"

describe "HotBook::BookingsManager class" do
  let(:hotel) { HotBook::Hotel.new }
  let(:bookingsmanager) { HotBook::BookingsManager.new(hotel) }
  let(:daterange) { HotBook::DateRange.new(
                    start_date: "apr_15", end_date: "apr_30") }
  let(:new_reservation) { bookingsmanager.new_reservation(daterange) }
  let(:load_reservations) { hotel.reservations }
  let(:block) { HotBook::Block.new(daterange, ["1", "2", "3", "4", "5"]) }
  let(:rooms) { ["1", "2", "3", "4", "5"] }
  let(:load_block) { bookingsmanager.new_block(daterange, rooms) }
  let(:date) {Date.parse("apr_15")}
  let(:overlaprange) { HotBook::DateRange.new( start_date: "apr_08",
                                               end_date: "apr_16") }
  let(:shortrange) { HotBook::DateRange.new( start_date: "may_01",
                                               end_date: "may_02") }
  let(:current_block){bookingsmanager.blocks[0]}

  before do
    # Test reservation data is loaded into @reservations:
    bookingsmanager
    # A single block, rooms 1-5, 4/15-4/30, is loaded into @blocks:
    block = load_block

    # This mimics what would happen if test reservations 6-9 were actually
    # created as block reservations:
    block.disable("1")
    block.disable("2")
    block.disable("3")
    block.disable("4")
  end

  describe "new_reservation method" do
    it "creates a Reservation object and stores in @reservations" do
      expect(new_reservation).must_be_instance_of HotBook::Reservation
      expect(bookingsmanager.reservations.size).must_equal 11
      3.times {bookingsmanager.new_reservation(daterange) }
      expect(bookingsmanager.reservations.size).must_equal 11 + 3
    end

    it "raises unique errors if room is booked or blocked during daterange" do
      expect{bookingsmanager.new_reservation(daterange, room_number: "6")}.must_raise HotBook::RoomIsTakenError
      expect{bookingsmanager.new_reservation(daterange, room_number: "1")}.must_raise HotBook::RoomIsBlockedError
    end
  end

  describe "suggest_room method" do
    it "returns the first publicly available room number that isn't booked or blocked" do
      expect(bookingsmanager.suggest_room(daterange)).must_equal "7"
    end
  end

  describe "edge case extravaganza: being super sure you can't overbook" do
    it "new reservation nominal case" do
      20.times{bookingsmanager.new_reservation(shortrange)}
      expect(bookingsmanager.reservations.last.room_number).must_equal "20"
    end

    it "new reservation edge case" do
      expect{ 21.times { bookingsmanager.new_reservation(shortrange) } }.must_raise HotBook::NoRoomsAvailableError
      expect{bookingsmanager.new_reservation(shortrange, room_number: "1")}.must_raise HotBook::RoomIsTakenError
    end

    it "new block case" do
      expect{2.times { bookingsmanager.new_block(shortrange, rooms)} }.must_raise HotBook::BlockConflictError
    end

    it "new_block_reservation case" do
      new_block = bookingsmanager.new_block(shortrange, rooms)
      expect{ 6.times{ bookingsmanager.new_block_reservation(new_block) } }.must_raise HotBook::NoRoomsAvailableError
    end
  end

  describe "new_block_reservation method" do
    it "will remove the room from block's memo array of what's still reservable" do
      expect(current_block.available.size).must_equal 1
      bookingsmanager.new_block_reservation(current_block)
      expect(current_block.available.size).must_equal 0
    end

    it "will raise an error if the room number given is not in the given block" do
      expect{bookingsmanager.new_block_reservation(current_block, room_number: "20")}.must_raise ArgumentError
    end

    it "will raise an error if the room is in the block, but already booked" do
      expect{bookingsmanager.new_block_reservation(current_block, room_number: "1")}.must_raise HotBook::RoomIsTakenError
    end

    it "will add the new reservation to the @reservations array" do
      expect(bookingsmanager.reservations.last.room_number).must_equal "6"
      bookingsmanager.new_block_reservation(current_block)
      expect(bookingsmanager.reservations.last.room_number).must_equal "5"
    end
  end

  describe "new_block method" do
    it "cannot overlap or conflict with an existing block" do
      expect{bookingsmanager.new_block(daterange, rooms)}.must_raise HotBook::BlockConflictError
    end

    it "cannot overlap or conflict with an existing reservation" do
      expect{bookingsmanager.new_block(overlaprange, rooms)}.must_raise HotBook::RoomIsTakenError
      expect{bookingsmanager.new_block(daterange, ["6"])}.must_raise HotBook::RoomIsTakenError
    end

    it "cannot contain more than 5 rooms" do
      bad_rooms = %w(1 2 3 4 5 6)
      expect{bookingsmanager.new_block(daterange, bad_rooms)}.must_raise ArgumentError
    end
  end

  describe "list_by_nights method" do
    it "returns an array of reservations excluding checkout date" do
      expect(bookingsmanager.list_by_nights(date).size).must_equal 1
      expect(bookingsmanager.list_by_nights(date)[0].room_number).must_equal "6"
    end
  end

  describe "public_avail_rooms method" do
    it "returns an array of room numbers that aren't booked or blocked" do
      list = %w(7 8 9 10 11 12 13 14 15 16 17 18 19 20)
      expect(bookingsmanager.public_avail_rooms(overlaprange)).must_equal list
      bookingsmanager.new_reservation(overlaprange)
      list.shift
      expect(bookingsmanager.public_avail_rooms(overlaprange)).must_equal list
    end
  end

  describe "room_taken? method" do
    it "given daterange, lists rezzies with conflict, " \
    "and tells you if the given room is in that list" do
      expect(bookingsmanager.room_taken?(daterange, "6")).must_equal true
      expect(bookingsmanager.room_taken?(daterange, "1")).must_equal false
    end
  end

  describe "room_blocked? method" do
    it "given daterange, lists blocks with conflict, " \
    "and tells you if the given room is in that list" do
      expect(bookingsmanager.room_blocked?(daterange, "1")).must_equal true
      expect(bookingsmanager.room_blocked?(daterange, "6")).must_equal false
    end
  end

  describe "conflicting_reservations method" do
    it "returns an array of reservations with a daterange conflict" do
      array = bookingsmanager.conflicting_reservations(daterange)
      expect(array.size).must_equal 1
      expect(array[0]).must_be_instance_of HotBook::Reservation
    end
  end

  describe "conflicting_blocks method" do
    it "returns an array of blocks with a daterange conflict" do
      array = bookingsmanager.conflicting_blocks(daterange)
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
      expect{bookingsmanager.new_reservation(bad_range)}.must_raise ArgumentError
      expect{bookingsmanager.new_reservation(daterange, room_number: bad_room_number)}.must_raise ArgumentError
      expect{bookingsmanager.list_by_nights(bad_date)}.must_raise ArgumentError
      expect{bookingsmanager.new_block(daterange, bad_rooms)}.must_raise ArgumentError
      expect{bookingsmanager.new_block(daterange, another_bad_rooms)}.must_raise ArgumentError
      expect{bookingsmanager.new_block_reservation(bad_block, room_number: "2")}.must_raise ArgumentError
    end
  end
end
