require_relative 'spec_helper'

describe "Hotel Manager class" do
  before do
     hotel = Hotel_Dispatcher.new
  end

  it 'has an array of all rooms in hotel' do
    expect(hotel.rooms).must_be_kind_of Array
  end

  it 'has 20 rooms in the hotel' do
    expect(hotel.rooms.length).must_equal 20
  end

  it 'each index of the array is an instance of class' do
    expect(hotel.rooms[0]).must_be_kind_of Room
  end

end
