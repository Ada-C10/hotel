require_relative "spec_helper"

describe "HotBook::Hotel class" do
  let(:hotel) { HotBook::Hotel.new }
  let(:room_rate) { hotel.room_rate }
  let(:room_numbers) { hotel.room_numbers }
  let(:rooms) { hotel.rooms }
  let(:valid_room_numbers) { ["1", "2", "3", "4", "5", "6", "7", "8", "9",
                              "10", "11", "12", "13", "14", "15", "16", "17",
                              "18", "19", "20"] }

  describe "initialize method" do
    it "loads room rate correctly" do
      expect(room_rate).must_be_instance_of Float
      expect(room_rate).must_equal 200.0
    end

    it "loads room numbers correctly" do
      expect(room_numbers).must_equal valid_room_numbers
    end

    it "upcases room numbers before storing them" do
      test_room_numbers_filename = "support/test_room_numbers.csv"
      hotel = HotBook::Hotel.new(room_numbers: test_room_numbers_filename)
      expect(hotel.room_numbers).must_equal ["ROOM THIRTEEN"]
    end
  end

## Project Requirement: User can view a list of rooms
  describe "load_rooms method" do
    it "room numbers are all valid-type key/value pairs" do
      rooms.each_with_index do |room, index|
        expect(room[:room_number]).must_be_instance_of String
        expect(room[:room_number]).must_equal valid_room_numbers[index]
      end
    end

    it "room rates are all valid-type key/value pairs" do
      rooms.each do |room|
        expect(room[:room_rate]).must_equal 200.0
      end
    end
  end

  describe "project requirement: user can view a list of rooms" do
    # This requires that test(s) MUST pass for "load rooms method"
    it "can return a list of rooms" do
      expect(hotel.rooms).must_be_instance_of Array
    end
  end

# TODO: AFter the CSV load function is added
# write both these tests
##### THIS ISN'T REALLY TESTING THAT MUCH
  describe "find_rate method" do
    it "Hotel object can look up the correct room" do
      expect(hotel.find_rate("3")).must_equal 200.0
    end
    #
    # it "handles edge case @rooms = nil" do
    # end
  end
end
