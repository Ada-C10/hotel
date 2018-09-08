require_relative "spec_helper"

describe "Hotel::Book class" do
  let(:hotel) { HotBook::Hotel.new }
  let(:book) { HotBook::Book.new(hotel) }
  let(:daterange) { HotBook::DateRange.new(start_date: "apr_1", end_date: "apr_6") }
  let(:new_reservation) { book.new_reservation(daterange) }

  describe "initialize method" do
    it "initializes an empty array for reservations" do
      expect(book.reservations).must_equal []
    end
  end

  describe "new_reservation method" do
    it "raises ArgError if the argument isn't a DateRange" do
      badrange = "some_string"
      expect{book.new_reservation(badrange)}.must_raise ArgumentError
    end

    it "creates a Reservation object and stores in @reservations" do
      expect(book.reservations).must_equal []
      expect(new_reservation).must_be_instance_of HotBook::Reservation
      expect((book.reservations).size).must_equal 1
      4.times do
        new_reservation = book.new_reservation(daterange)
      end
      expect((book.reservations).size).must_equal 5
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

  describe "list_by_date" do
    it "raises ArgError if the arg isn't a Date" do
      baddate = "some_string"
      expect{book.list_by_date(baddate)}.must_raise ArgumentError
    end

    it "returns an array of reservations " do
      new_reservation = book.new_reservation(daterange)
      date = Date.parse("apr_6")
      list = book.list_by_date(date)
      expect(list).must_be_instance_of Array
      expect(list.size).must_equal 1
    end
  end

end
