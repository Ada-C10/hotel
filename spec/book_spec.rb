require_relative "spec_helper"

describe "HotBook::Book class" do
  let(:hotel) { HotBook::Hotel.new }
  let(:book) { HotBook::Book.new(hotel) }
  let(:daterange) { HotBook::DateRange.new(
                    start_date: "apr_1", end_date: "apr_2") }
  let(:new_reservation) { book.new_reservation(daterange) }

  describe "new_reservation method" do
    it "raises ArgError if the argument isn't a DateRange" do
      badrange = "some_string"
      expect{book.new_reservation(badrange)}.must_raise ArgumentError
    end

    it "creates a Reservation object and stores in @reservations" do
      expect(new_reservation).must_be_instance_of HotBook::Reservation
      previous_size = book.reservations.size
      3.times { book.new_reservation(daterange) }
      expect((book.reservations).size).must_equal previous_size + 3
    end
  end

  describe "default_room method" do
    it "returns what you friggin want" do
      expect(book.default_room).must_equal "1"
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

  describe "list_available_rooms method" do
    it "returns an array that's a subset (or equal to) all room numbers" do
      all = hotel.room_numbers
      list = book.list_available_rooms(daterange)
      expect(book.reservations.size).must_equal 6
      expect((all - list).size).must_equal (all.size - list.size)
      expect(list.first).must_equal "4"
      expect(list.last).must_equal "20"
    end
  end
end
