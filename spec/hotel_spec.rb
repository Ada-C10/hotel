require_relative "spec_helper"

describe "HotBook::Hotel class" do
  let(:args) {{room_count: 20, room_rate: 200.0}}
  let(:hotel) {HotBook::Hotel.new(args)}
  let(:room_count) {hotel.room_count}
  let(:room_rate) {hotel.room_rate}
  let(:all_rooms) {hotel.rooms}
  let(:expected_room_rate) {200.0}
  let(:expected_room_count) {20}

  describe "initialize arguments" do
    it "loads room count correctly" do
      expect(room_count).must_be_instance_of Integer
      expect(room_count).must_equal expected_room_count
    end

    it "loads room rate correctly" do
      expect(room_rate).must_be_instance_of Float
      expect(room_rate).must_equal expected_room_rate
    end
  end

  describe "loading and returning list of all rooms" do
    it "rooms is initialized as array of hashes with correct number of rooms" do
      expect(all_rooms).must_be_instance_of Array
      all_rooms.each do |room|
        expect(room).must_be_instance_of Hash
      end
      expect(all_rooms.size).must_equal room_count
    end

    it "room numbers are all valid key/value pairs" do
      valid_room_numbers = %i(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
      all_rooms.each_with_index do |room, index|
        expect(room[:room_number]).must_be_instance_of Symbol
        expect(room[:room_number]).must_equal valid_room_numbers[index]
      end
    end

    it "room rates are all valid key/value pairs" do
      valid_room_rates = Array.new(size= expected_room_count, default = expected_room_rate)
      all_rooms.each_with_index do |room, index|
        expect(room[:room_rate]).must_be_instance_of Float
        expect(room[:room_rate]).must_equal valid_room_rates[index]
      end
    end
  end

end

# - hotel class can return a list of all rooms
# - loader class loads hotel class with rooms (argument is number of rooms) ##### really?
# rooms are a hash
# hash has 20 elements
# expect values at :room_number to be 1-20
# hash keys are :room_number and :room_rate (float)
# expect :room_rate for all to be 200
