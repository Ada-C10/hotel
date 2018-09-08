require_relative 'spec_helper'

describe "Block" do
  let (:my_hotel) {
    Hotel::HotelManager.new
  }
  let (:start_date) {
    "2018-10-07"
  }
  let (:end_date) {
    "2018-10-16"
  }
  let (:group_name) {
    "Comic-Con"
  }
  let (:room_rate) {
    145
  }
  let (:room_list) {
    [2, 3, 6, 15, 18]
  }
  let (:my_block) {
    Hotel::Block.new(group_name, room_list, start_date: start_date, end_date: end_date, room_rate: 145)
  }

  describe "#initialize" do
    it "Creates an instance of Block" do
      expect(my_block).must_be_kind_of Hotel::Block
    end

    it "Keeps track of all parameters" do
      [:group_name, :start_date, :end_date, :room_list, :room_rate].each do |variable|
        expect(my_block).must_respond_to variable
      end

      expect(my_block.group_name).must_equal "Comic-Con"
      expect(my_block.start_date).must_equal start_date
      expect(my_block.end_date).must_equal end_date
      expect(my_block.room_list).must_be_kind_of Hash
      expect(my_block.room_rate).must_equal 145
    end
  end

  describe "all_available_rooms_in_block" do
    before do
      @group_name = "MFALA"
    end

    it "Returns the correct number of rooms as an array" do
      list = Hotel::Block.all_available_rooms_in_block(my_hotel.blocks, @group_name)

      expect(list.length).must_equal 5
      expect(list).must_be_kind_of Array
    end

    it "Returns nil if no rooms can be found" do
      @my_block = my_hotel.blocks.find {|block| block.group_name == @group_name}
      room_numbers = @my_block.room_list.keys
      room_numbers.each do |num|
        @my_block.room_list[num] = :UNAVAILABLE
      end

      list = Hotel::Block.all_available_rooms_in_block(my_hotel.blocks, @group_name)

      expect(list).must_be_nil
    end
  end

  describe "find_block" do
    it "Returns the block instance corresponding to the group name" do
      new_block = Hotel::Block.find_block(my_hotel.blocks, "NCTM")
      expect(new_block.room_rate).must_equal 160
    end

    it "Returns nil if the block cannot be found" do
      new_block = Hotel::Block.find_block(my_hotel.blocks, "Puzzled Pint People")
      expect(new_block).must_be_nil
    end
  end
end
