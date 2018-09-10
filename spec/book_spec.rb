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

  describe "new_reservation method" do

    it "creates a Reservation object and stores in @reservations" do
      expect(new_reservation).must_be_instance_of HotBook::Reservation
      previous_size = book.reservations.size
      3.times { book.new_reservation(daterange) }
      expect((book.reservations).size).must_equal previous_size + 3
    end

    it "correctly raises error if room is already reserved during daterange" do
      book
      load_block
      expect{book.new_reservation(daterange, room_number: "20")}.must_raise HotBook::RoomIsTakenError
      expect{book.new_reservation(daterange, room_number: "1")}.must_raise HotBook::RoomIsBlockedError
    end

    it "correctly raises error if room is part of a block during daterange" do

    end

  end
  #
  # describe "suggested_room method" do
  #   it "returns the correct room number" do
  #     expect(book.suggested_room(daterange)).must_equal "4"
  #   end
  # end
  #
  # describe "default_rate method" do
  #   it "does the right thing" do
  #     expect(book.default_rate).must_equal 200.0
  #   end
  # end

### PROJECT REQ: User can access the list of reservations for a specific date
  # describe "list_reservations" do
  #   it "raises ArgError if the arg isn't a Date" do
  #     baddate = "some_string"
  #     expect{book.list_reservations(baddate)}.must_raise ArgumentError
  #   end
  #
  #   it "returns an array of reservations " do
  #     note = "This is the first reservation"
  #     date = Date.parse("apr_6")
  #     list = book.list_reservations(date)
  #     expect(list).must_be_instance_of Array
  #     expect(list.first.notes).must_equal note
  #   end
  # end

  # describe "room_is_bookable? method" do
  #   it "correctly checks if a room has a reservation on that date" do
  #     room_number = "10"
  #     expect(book.room_is_bookable?(room_number, daterange)).must_equal true
  #     room_number = "2"
  #     expect{book.room_is_bookable?(room_number, daterange)}.must_raise StandardError
  #   end
  # end

  # describe "list_available_room_numbers method" do
  #   it "returns an array that's a subset (or equal to) all room numbers" do
  #     all = hotel.room_numbers
  #     list = book.list_available_room_numbers(daterange)
  #     expect(book.reservations.size).must_equal 6
  #     expect((all - list).size).must_equal (all.size - list.size)
  #     expect(list.first).must_equal "4"
  #     expect(list.last).must_equal "20"
  #   end
  # end

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
