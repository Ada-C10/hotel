require_relative 'spec_helper'

describe 'Room class' do

  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new({room_number: 1, price: 200})
    end

    it "it is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "throws an argument error with a invalid room_number" do
      expect{
        Hotel::Room.new({room_number: 0, price: 200})
      }.must_raise ArgumentError

      expect{
        Hotel::Room.new({room_number: 21, price: 200})
      }.must_raise ArgumentError
    end

    it "throws an argument error if price is not 200" do
      expect{
        Hotel::Room.new({room_number: 1, price: 100})
      }.must_raise ArgumentError

      expect{
        Hotel::Room.new({room_number: 1, price: 400})
      }.must_raise ArgumentError
    end

    it "is set up for specific attributes and data types" do
      [:room_number, :price].each do |prop|
        expect(@room).must_respond_to prop
      end

      expect(@room.room_number).must_be_kind_of Integer
      expect(@room.price).must_be_kind_of Integer
    end
  end
end
