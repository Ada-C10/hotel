require_relative 'spec_helper'
require_relative '../lib/block'

describe 'Block class' do

  describe "#initialize" do
    before do
      attributes = {rooms: [] ,start_time: Date.new(2018,8,1),end_time: Date.new(2018,9,1), discount: 10, block: :A}
      @block = Block.new(attributes)
    end

    it 'is an instance of Reservation' do
      expect(@block).must_be_kind_of Block
    end

    it "is set up for specific attributes and data types" do
      [:rooms, :start_time, :end_time, :discount, :block].each do |attribute|
        expect(@block).must_respond_to attribute
      end

      expect(@block.rooms).must_be_kind_of Array
      expect(@block.start_time).must_be_kind_of Date
      expect(@block.end_time).must_be_kind_of Date
      expect(@block.discount).must_be_kind_of Integer
      expect(@block.block).must_be_kind_of Symbol
    end
  end
end
