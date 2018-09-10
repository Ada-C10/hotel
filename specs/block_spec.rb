require_relative 'spec_helper'
require 'pry'

describe "Block class" do
  before do
    @start_date = Date.today
    @end_date = Date.today + 5
    @date_range = Hotel::DateRange.new(@start_date, @end_date)

    @block_data = {
      id: 8,
      party: 5,
      date_range: @date_range
    }
    @block = Hotel::Block.new(@block_data)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@block).must_be_kind_of Hotel::Block
    end
  end
end
