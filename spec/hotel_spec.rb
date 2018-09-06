require_relative "spec_helper"

describe "HotBook::Hotel class" do
  let(:room_count) {20}
  let (:hotel) {HotBook::Hotel.new(:room_count)}

  describe "#initialize" do
    before {all_rooms = hotel.rooms}

    it "Hotel has reader method for rooms" do
      expect(hotel).must_respond_to rooms
    end

    it "rooms returns an array of hashes with the correct number of rooms" do
      expect(all_rooms).must_be_instance_of Array
      all_rooms.each {|room| expect(room).must_be_instance_of Hash}
      expect(all_rooms.size).must_equal room_count
    end

    it "room numbers are all valid key/value pairs" do
      valid_room_numbers = %i(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
      all_room_numbers = rooms.flat_map{ |room| room.values_at(:room_number) }
      expec(all_room_numbers).must_equal valid_room_numbers
    end

    it "room rates are all valid key/value pairs" do
      valid_room_rates = Array.new(size= room_count, default = 200.0)
      all_room_rates = rooms.flat_map{ |room| room.values_at(:room_rate) }
      expect(all_room_rates).must_equal valid_room_rates
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
