require_relative 'spec_helper'


describe "Room in Wave 1" do
  describe "#initialize" do
    it "Takes a room number" do
      id = 1
      room_1 = Room.new(id)

      expect(room_1).must_respond_to :room_num
      expect(room_1.room_num).must_equal id
      expect(room_1.rate).must_equal 200
      expect(room_1.reserve_dates).must_equal []

    end

    it "Raises an ArgumentError for invalid room numbers" do
      expect {
          Room.new('a')
        }.must_raise ArgumentError
      expect {
          Room.new(21)
        }.must_raise ArgumentError
    end
  end

  describe "#update_reserve_dates" do
    before do
      @room_1 = Room.new(3)
      @date1 = Date.new(2018,10,4)
      @date2 = Date.new(2018,10,5)
      @new_reserve_dates = [ @date1, @date2 ]
      @previous = @room_1.reserve_dates.length
      @room_1.add_reserve_dates(@new_reserve_dates)
    end

    it "increases the reserve_dates array length correctly" do
      expect(@room_1.reserve_dates.length).must_equal @previous + 2
    end

    it "the updated reseve_dates array should include the newly added dates" do
      expect(@room_1.reserve_dates).must_include @date1
      expect(@room_1.reserve_dates).must_include @date2
    end

    it "throw ArgumentError if attemp to add a specific date to the list twice or more" do
      expect{ @room_1.add_reserve_dates([@date1]) }.must_raise ArgumentError
    end

  end
end
