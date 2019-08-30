require_relative 'spec_helper'
require 'date'

describe 'BlockReservation' do
  describe 'initialize' do
    before do
      input = { id: 111, guest_name: '',
                included_rooms: [1, 2, 3, 4],
                rsv_start: 'March 3, 2019',
                rsv_end: 'March 5, 2019',
                group_name: 'testingtons',
                room_qty: 3 , status: :BLOCK }
      @new_block = Hotel::BlockReservation.new(input)
    end
    it 'can create a block reservation' do
      expect(@new_block).must_be_kind_of Hotel::BlockReservation
    end
    it 'creates proper data structures' do
      expect(@new_block.guest_name).must_be_kind_of String
      expect(@new_block.room_qty).must_be_kind_of Integer
      expect(@new_block.status).must_be_kind_of Symbol
    end

    it 'raises an error if group name is empty' do
      input = { id: 999, guest_name: '',
                included_rooms: [1, 2, 3],
                rsv_start: 'March 3, 2019',
                rsv_end: 'March 5, 2019', group_name: '',
                room_qty: 3, status: :BLOCK }
      expect{
        Hotel::BlockReservation.new(input)
      }.must_raise ArgumentError
    end
    it 'raises an error if number of rooms is < 2 or > 5' do
      input = { id: 999, guest_name: "pending",
                included_rooms: [],
                rsv_start: 'March 3, 2019',
                rsv_end: 'March 5, 2019',
                group_name: 'test', room_qty: 1 }
      expect{
        Hotel::BlockReservation.new(input)
      }.must_raise ArgumentError

      input2 = { id: 999, guest_name: "pending",
                included_rooms: [],
                rsv_start: 'March 3, 2019',
                rsv_end: 'March 5, 2019',
                 group_name: 'test', room_qty: 6 }
      expect{
        Hotel::BlockReservation.new(input2)
      }.must_raise ArgumentError
    end
    it 'defaults status to :BLOCK' do
      expect(@new_block.status).must_equal :BLOCK
    end

  end
end

