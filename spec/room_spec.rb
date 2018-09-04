require 'simplecov'
SimpleCov.start
require_relative 'spec_helper'

# describe "Room" do
  # ROOM_NUMBER = 1
  # AVAILIBILITY = availibility
  # room.new(room_number, availibility)

  describe 'initialize' do
    it 'takes a room number and checks the availibility' do
      room_number = 1
      availibility = :available
      room = Room.new(room_number, availibility)

      expect(room).must_respond_to :room_number
      expect(room.room_number).must_equal 1

      expect(room).must_respond_to :availibility
      expect(room.availibility).must_equal :available
    end
  end
# end
