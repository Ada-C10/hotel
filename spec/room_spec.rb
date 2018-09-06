require_relative 'spec_helper'
require_relative '../lib/room'

describe 'Room class' do

  describe "#initialize" do
    before do
      @room = Room.new(
        {room_num: 1, reserved_dates: [], block_status: :NA })
      end

      it 'is an instance of Room' do
        expect(@room).must_be_kind_of Room
      end

      it "is set up for specific attributes and data types" do
        [:room_num, :reserved_dates, :block_status].each do |attribute|
          expect(@room).must_respond_to attribute
        end

        expect(@room.room_num).must_be_kind_of Integer
        expect(@room.reserved_dates).must_be_kind_of Array
        expect(@room.block_status).must_be_kind_of Symbol

      end
    end


end #the Room class block
