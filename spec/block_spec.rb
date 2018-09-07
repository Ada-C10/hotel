require_relative 'spec_helper'

describe "Block" do
  let (:my_hotel) {
    Hotel::HotelManager.new
  }
  let (:check_in) {
    "2018-10-07"
  }
  let (:check_out) {
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
    Hotel::Block.new(group_name, check_in, check_out, room_list, room_rate)
  }

  describe "#initialize" do
    it "Creates an instance of Block" do
      expect(my_block).must_be_kind_of Hotel::Block
    end

    it "Keeps track of all parameters" do
      [:group_name, :check_in, :check_out, :room_list, :room_rate].each do |variable|
        expect(my_block).must_respond_to variable
      end

      expect(my_block.group_name).must_equal "Comic-Con"
      expect(my_block.check_in).must_equal Date.parse(check_in)
      expect(my_block.check_out).must_equal Date.parse(check_out)
      expect(my_block.room_list).must_equal [2, 3, 6, 15, 18]
      expect(my_block.room_rate).must_equal 145
    end
  end

  describe "#create_a_block" do

  end














end
