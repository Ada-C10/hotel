require_relative "spec_helper"

describe "HotBook::Hotel class" do
  let(:hotel) { HotBook::Hotel.new }
  let(:room_rate) { hotel.room_rate }
  let(:room_numbers) { hotel.room_numbers }
  let(:rooms) { hotel.rooms }
  let(:valid_room_numbers) { ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
                        "12", "13", "14", "15", "16", "17", "18", "19", "20"] }

  describe "initialize method" do
    it "loads room rate correctly" do
      expect(room_rate).must_be_instance_of Float
      expect(room_rate).must_equal 200.0
    end

    it "loads room numbers correctly" do
      expect(room_numbers).must_equal valid_room_numbers
    end

    it "upcases room numbers before storing them" do
      arg = ["room thirteen"]
      hotel = HotBook::Hotel.new(room_numbers: arg)
      expect(hotel.room_numbers).must_equal ["ROOM THIRTEEN"]
    end
  end

  describe "load_rooms method" do
    it "room numbers are all valid key/value pairs" do
      rooms.each_with_index do |room, index|
        expect(room[:room_number]).must_be_instance_of String
        expect(room[:room_number]).must_equal valid_room_numbers[index]
      end
    end

    it "room rates are all valid key/value pairs" do
      rooms.each do |room|
        expect(room[:room_rate]).must_equal 200.0
      end
    end
  end

  describe "find_room_by_number method" do
    it "raises StandardError if room not found" do
      query = "21"
      expect{hotel.find_room_by_number(query)}.must_raise StandardError
    end

    it "raises ArgumentError if query != String" do
      query = 21
      expect{hotel.find_room_by_number(query)}.must_raise ArgumentError
    end

    it "correctly finds the room you searched for" do
      found_room = hotel.find_room_by_number("13")
      expect(found_room).must_be_instance_of Hash
      expect(found_room[:room_number]).must_equal "13"
    end
  end

end
