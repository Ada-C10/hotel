require 'simplecov'
SimpleCov.start
require 'pry'

require_relative 'spec_helper'

describe 'ReservationTracker class' do
  describe 'initialize' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'has an array of all rooms in hotel' do
      expect(@reservation_tracker.create_rooms).must_be_kind_of Array
    end

    it 'has 20 rooms in the hotel' do
      expect(@reservation_tracker.create_rooms.length).must_equal 20
    end
  end
  # it 'returns a list of all the rooms in the hotel' do
  #   # arrange
  #   # act
  #   # assert
  #   expect(list_of_all_rooms.room_number).must_be_kind_of Array
  #
  # end
  describe 'list_of_all_rooms method' do
    before do
      @reservation_tracker = ReservationTracker.new
    end

    it 'returns an array of rooms in hotel' do
      expect(@reservation_tracker.list_of_all_rooms).must_be_kind_of Array
      # binding.pry
      expect(@reservation_tracker.list_of_all_rooms.length).must_equal 20
    end
  end
end
