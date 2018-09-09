require_relative 'spec_helper'
require 'date'

describe 'BlockReservation' do
  describe 'initialize' do
    it 'can create a block reservation' do
      # input = { id: 111, guest_name: "",
      #           included_rooms: [1,2,3,4],
      #           rsv_start: "March 3, 2019",
      #           rsv_end: "March 5, 2019" }
      @new_block = Hotel::BlockReservation.new(id: '999', guest_name: "",
                                               included_rooms: [1,2,3,4],
                                               rsv_start: "March 3, 2019",
                                               rsv_end: "March 5, 2019",
                                               group_name: "Block Testing",
                                               number_of_rooms:  4)

      expect(@new_block).must_be_kind_of Hotel::BlockReservation
    end
  end
end

