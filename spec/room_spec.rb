require_relative 'spec_helper'

describe "Room class" do
  before do
    @rooms = Room.new
    @array_of_used_rooms = [1, 2, 5, 10]
    @new_room = @rooms.find_available_room(@array_of_used_rooms)
  end

    describe "listing room numbers" do
      it "can list all of the rooms in the hotel" do
        expect (@rooms.rooms).must_be_kind_of Array
        expect (@rooms.rooms.length).must_equal 20
      end
    end

    describe "assigning room numbers" do
      it "assigns first available room as room_num" do
        expect (@new_room).must_equal 3
    end

      it "can assign a block of room numbers" do
        new_block = @rooms.find_block_of_rooms(5, @array_of_used_rooms)
        expect(new_block.length).must_equal 5
        expect(new_block).must_equal [3, 4, 6, 7, 8]
      end
  end
end
