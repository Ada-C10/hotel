require_relative 'spec_helper'

describe "RoomBlock" do

  let(:block) {Hotel::RoomBlock.new(
    id: "2",
    reservations: [1,2,3,4,5],
    check_in: "2004-7-1",
    check_out: "2004-7-4")}

  describe "#initialize" do
    it "can create a new instance of RoomBlock" do
      expect(block).must_be_kind_of Hotel::RoomBlock
      expect(block.id).must_equal 2
    end

    it "throws an error for an empty list of rooms" do
    expect {
      Hotel::RoomBlock.new(
        id: "2",
        reservations: [],
        check_in: "2004-7-1",
        check_out: "2004-7-4")}.must_raise StandardError
    end

    it "throws an error for a single room" do
    expect {
      Hotel::RoomBlock.new(
        id: "2",
        reservations: [1],
        check_in: "2004-7-1",
        check_out: "2004-7-4")}.must_raise StandardError
    end

    it "throws an error for too many rooms" do
    expect {
      Hotel::RoomBlock.new(
        id: "2",
        reservations: [1,2,3,4,5,6],
        check_in: "2004-7-1",
        check_out: "2004-7-4")}.must_raise StandardError
    end

    it "can create a room block with a one-night stay" do
      # edge case
      one_night_stay = Hotel::RoomBlock.new(
        id: "66",
        reservations: [1,2,3],
        check_in:"2009-7-29",
        check_out: "2009-7-30")
      expect(one_night_stay).must_be_kind_of Hotel::RoomBlock
      expect(one_night_stay.id).must_equal 66
    end

    it "sets daily rate to default value if no value given" do
      expect(block.daily_rate).must_equal 200
    end

    it "sets discount to default value if no value given" do
      expect(block.discount).must_equal 0
    end

    it "can override daily rate's default value" do
      expensive_stay = Hotel::RoomBlock.new(
        id: "66",
        reservations: [1,2,3],
        check_in:"2009-5-15",
        check_out: "2009-7-30",
        daily_rate: 500)

        expect(expensive_stay.daily_rate).must_equal 500
    end
  end

  describe "#discounted_rate" do
    it "accurately calculates discounted rate" do
        block_room = Hotel::RoomBlock.new(
        id: "66",
        reservations: [1,2,3],
        check_in:"2009-7-29",
        check_out: "2009-7-30",
        discount: 20)

      expect(block_room.discounted_rate).must_equal 160
    end
  end

  describe "#total_stay_cost_room" do
    it "accurately calculates the total cost for one room within the block" do
      block_room = Hotel::RoomBlock.new(
      id: "66",
      reservations: [1,2,3],
      check_in:"2009-7-29",
      check_out: "2009-7-30")

      expect(block_room.total_stay_cost_room).must_equal 200.0
    end
  end

    describe "#total_stay_cost_block" do
      it "accurately calculates the total cost for one room within the block" do
        entire_block = Hotel::RoomBlock.new(
        id: "66",
        reservations: [1,2,3],
        check_in:"2009-7-29",
        check_out: "2009-7-30")

        expect(entire_block.total_stay_cost_block).must_equal 600
      end
    end
  # end

  #   # QUESTION: do we need error handling for numeric value for daily_rate?
  #   it "can override default value for daily rate" do
  #   rare_room = Hotel::RoomBlock.new(
  #     id: "66",
  #     room_num: "19",
  #     check_in:"2009-7-29",
  #     check_out: "2009-7-30",
  #     daily_rate: 500)
  #
  #     expect(rare_room.daily_rate).must_equal 500
  #   end
  # end

  # describe "#total_stay_cost" do
  #   it "correctly calculates total cost for a reservation" do
  #     rate = reservation.daily_rate
  #     dates = 3
  #     correct_cost = rate * dates
  #
  #     expect(reservation.total_stay_cost).must_equal 600
  #   end
  # end
end
