require_relative 'spec_helper'

describe Hotel::Block do
  let(:calendar) {
    Hotel::Calendar.new(20)
  }
  let(:block2) {
    Hotel::Block.new('181202', '181206', 2)
  }
  let(:block3) {
    Hotel::Block.new('181202', '181206', 3)
  }
  let(:block4) {
    Hotel::Block.new('181202', '181206', 4)
  }
  let(:block5) {
    Hotel::Block.new('181202', '181206', 5)
  }
  let(:block6) {
    Hotel::Block.new('181202', '181206', 6)
  }
  let(:block1) {
    Hotel::Block.new('181202', '181206', 1)
  }
  let(:reservation1) {
    Hotel::Reservation.new('181202', '181204')
  }

  describe "#initalize" do
    it "can be instantiated" do
      expect(block2).must_be_kind_of Hotel::Block
      rooms = block2.number_of_rooms
    end
    it "raises ArgumentError if number_of_rooms not in range" do
      expect{Hotel::Block.new('181202', '181206', 6)}.must_raise ArgumentError
      expect{Hotel::Block.new('181202', '181206', 1)}.must_raise ArgumentError
    end
    it "calculates cost with discount based on number_of_rooms" do
      expect(block2.cost).must_equal 790
      expect(block3.cost).must_equal 780
      expect(block4.cost).must_equal 770
      expect(block5.cost).must_equal 760
    end
    it "stores hash of rooms and status" do
      expect(block2.rooms).must_be_kind_of Hash
      expect(block2.rooms).must_be_empty
    end
  end

end
