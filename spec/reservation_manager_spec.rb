# describe 'calculate_total_cost' do
#   it 'will calculate correct total' do
#     expect(@reservation.calculate_total_cost).must_equal 200 * 3
#   end
#
#   it 'will save correct total to instance variable total_cost' do
#     expect(@reservation.total_cost).must_equal 200 * 3
#   end
# end

# #THROW THIS TEST IN ReservationMatcher?
#     it 'will throw an error if you try to generate more than 20 rooms' do
#       expect{rooms = []
#         21.times do
#         room = Hotel::Room.new
#       rooms << room end }.must_raise StandardError
#     end

#room numbers initialized
#make not constant so can access length and test
# it 'will initialize one new room with a room_number 1-20' do
#   expect((1..20).include?(@room.room_number)).must_equal true
# end

require_relative 'spec_helper'

describe 'ReservationManager' do
  let(:manager){ manager = Hotel::ReservationManager.new() }


  describe 'initialize' do

    it 'is set up for specific instance variables and data types' do


      expect(manager.reservations).must_be_kind_of Array
      expect(manager.rooms).must_be_kind_of Array
  
    end

    it 'will populate 20 rooms' do

      expect(manager.rooms[0]).must_be_instance_of Hotel::Room

    end
  end

end

  # def initialize
  #   @reservations = []
  #   # raise StandardError.new('Created too many rooms.') if VALID_ROOMS.empty?
  #   @rooms |= VALID_ROOMS.length.times.map { |room| Room.new(generate_room_id) }
  #   #where to put above?
  # end
