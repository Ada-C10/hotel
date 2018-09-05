require 'simplecov'
SimpleCov.start
require_relative 'spec_helper'

  describe 'initialize' do
    it 'takes a room number' do
      room_number = 1
      # availibility = :available
      room = Room.new(room_number)

      expect(room).must_respond_to :room_number
      expect(room.room_number).must_equal room_number

      # expect(room).must_respond_to :availibility
      # expect(room.availibility).must_equal :available
    end
  end

    # it 'raises an ArgumentError for an invalid room status' do
    #     invalid_status = ['here', 15, :bogus, nil]
    #     invalid_status.each do |availibility|
    #       expect {
    #         Room.new(1, availibility)
    #       }.must_raise ArgumentError
    #     end
    # end

    # it 'raises an ArgumentError for an invalid room number' do
    #   invalid_room = [21 , -3, nil]
    #   invalid_room.each do |room|
    #     expect {
    #       Room.new(room_number, availibility).must_raise ArgumentError
    #     }
    #   end
    # end

    # describe 'is room available' do
    #
    # end
  # end
# end
