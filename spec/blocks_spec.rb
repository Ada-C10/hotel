require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'spec_helper'
require_relative '../lib/booking_system.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/date_range.rb'

describe "initialize" do
  before do
    @new_block_res = Hotel::Blocks.new([{room_number: 1}, {room_number: 2}, {room_number: 3}, {room_number: 4}], 200.00, "2018-02-03", "2018-02-06")
  end

  it "is an instance of Blocks" do
      expect(@new_block_res).must_be_kind_of Hotel::Blocks
    end

  it "Takes date_range, collection_of_rooms and cost per night" do

    expect(@new_block_res).must_respond_to :date_range
    expect(@new_block_res).must_respond_to :collection_of_rooms
    expect(@new_block_res).must_respond_to :cost_per_night

  end

  it "is set up for specific attributes and data types" do
    [:date_range, :collection_of_rooms, :cost_per_night].each do |initial|
      expect(@new_block_res).must_respond_to initial
    end

    expect(@new_block_res.date_range).must_be_kind_of Hotel::DateRange
    expect(@new_block_res.collection_of_rooms).must_be_kind_of Array
    expect(@new_block_res.cost_per_night).must_be_kind_of Float


  end
end
