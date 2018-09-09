require_relative "spec_helper"

describe "HotBook::Book class" do
  let(:hotel) { HotBook::Hotel.new }
  let(:book) { HotBook::Book.new(hotel) }
  let(:daterange) { HotBook::DateRange.new(
                    start_date: "apr_1", end_date: "apr_2") }
  let(:new_reservation) { book.new_reservation(daterange) }

  describe "new_reservation method" do
    it "raises ArgError if the daterange isn't a DateRange" do
      badrange = "some_string"
      expect{book.new_reservation(badrange)}.must_raise ArgumentError
    end

    it "raises ArgError if the room number isn't a String" do
      bad_room_number = 99
      expect{book.new_reservation(daterange, room_number: bad_room_number)}.must_raise ArgumentError
    end

    it "raises StandardError if there's no room by that number" do
      bad_room_number = "not a room number"
      expect{book.new_reservation(daterange, room_number: bad_room_number)}.must_raise StandardError
    end

    it "creates a Reservation object and stores in @reservations" do
      expect(new_reservation).must_be_instance_of HotBook::Reservation
      previous_size = book.reservations.size
      3.times { book.new_reservation(daterange) }
      expect((book.reservations).size).must_equal previous_size + 3
    end
  end

  describe "suggested_room method" do
    it "returns the correct room number" do
      expect(book.suggested_room(daterange)).must_equal "4"
    end
  end

  describe "default_rate method" do
    it "does the right thing" do
      expect(book.default_rate).must_equal 200.0
    end
  end

### PROJECT REQ: User can access the list of reservations for a specific date
  describe "list_reservations" do
    it "raises ArgError if the arg isn't a Date" do
      baddate = "some_string"
      expect{book.list_reservations(baddate)}.must_raise ArgumentError
    end

    it "returns an array of reservations " do
      note = "This is the first reservation"
      date = Date.parse("apr_6")
      list = book.list_reservations(date)
      expect(list).must_be_instance_of Array
      expect(list.first.notes).must_equal note
    end
  end

  describe "room_is_bookable? method" do
    it "correctly checks if a room has a reservation on that date" do
      room_number = "10"
      expect(book.room_is_bookable?(room_number, daterange)).must_equal true
      room_number = "2"
      expect{book.room_is_bookable?(room_number, daterange)}.must_raise StandardError
    end
  end

  describe "list_available_room_numbers method" do
    it "returns an array that's a subset (or equal to) all room numbers" do
      all = hotel.room_numbers
      list = book.list_available_room_numbers(daterange)
      expect(book.reservations.size).must_equal 6
      expect((all - list).size).must_equal (all.size - list.size)
      expect(list.first).must_equal "4"
      expect(list.last).must_equal "20"
    end
  end
end
