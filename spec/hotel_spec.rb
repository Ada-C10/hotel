require_relative 'spec_helper'

describe 'initialize' do
  before do
    @my_hotel = Hotel.new
    @room_list = @my_hotel.room_list
  end

  it 'creates a new Hotel instance' do
    expect(@my_hotel).must_be_instance_of Hotel
  end

  it 'populates a list of 20 rooms in the hotel' do
    expect(@room_list).must_be_instance_of Array
    expect(@room_list.length).must_equal 20
  end

  it 'each item in the rooms array is a type of Room object' do
    20.times do |i|
    expect(@room_list[i]).must_be_instance_of Room
    end
  end







end
