require_relative 'spec_helper'

describe Block do
  let(:block2) {
    Block.new('181202', '181206', 2)
  }
  let(:block3) {
    Block.new('181202', '181206', 3)
  }
  let(:block4) {
    Block.new('181202', '181206', 4)
  }
  let(:block5) {
    Block.new('181202', '181206', 5)
  }
  let(:block6) {
    Block.new('181202', '181206', 6)
  }
  let(:block1) {
    Block.new('181202', '181206', 1)
  }
  describe "#initalize" do
    it "can be instantiated" do
      expect(block2).must_be_kind_of Block
    end
    it "raises ArgumentError if number_of_rooms not in range" do
      expect{Block.new('181202', '181206', 6)}.must_raise ArgumentError
      expect{Block.new('181202', '181206', 1)}.must_raise ArgumentError
    end
    it "assigns discount based on number_of_rooms" do
      expect(block2.discount).must_equal 10
      expect(block3.discount).must_equal 20
      expect(block4.discount).must_equal 30
      expect(block5.discount).must_equal 40
    end
    it "includes discount in cost" do
      expect(block2.cost).must_equal 790
      expect(block3.cost).must_equal 780
      expect(block4.cost).must_equal 770
      expect(block5.cost).must_equal 760
    end
    it "stores hash of rooms" do
      expect(block2.rooms).must_be_kind_of Hash
      expect(block2.rooms).must_be_empty
    end
  end
  describe "#number_of_rooms" do

  end
end
