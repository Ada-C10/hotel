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
  describe "#initalize" do
    it "can be instantiated" do
      expect(block2).must_be_kind_of Block
    end
  end
end
