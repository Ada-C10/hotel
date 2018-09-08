# require_relative 'spec_helper'
#
# describe 'Lodging module methods' do
#
#   describe 'create rooms' do
#     before(:each) do
#       Lodging::Room.class_variable_set(:@@room_list, [])
#     end
#
#     let(:concierge) {
#       Lodging::Concierge.new(10)
#     } ##uses the create_rooms method
#
#     it 'creates mulitiple instances of room' do
#       concierge
#
#       expect(Lodging::Room.show_list).must_be_instance_of Array
#       expect(Lodging::Room.show_list.any? Lodging::Room).must_equal true
#
#       expect(concierge.all_rooms.length).must_equal 10
#     end
#
#     it 'assigns different room numbers to each instance up to x times' do
#       Lodging.create_rooms(10)
#       first = Lodging::Room.show_list.first
#       last = Lodging::Room.show_list.last
#
#       expect(Lodging::Room.show_list.length).must_equal 10
#       expect(first.room_number).must_equal 1
#       expect(last.room_number).must_equal 10
#     end
#
#     it 'errors if argument passed is not integer' do
#       expect{Lodging.create_rooms('forty')}.must_raise ArgumentError
#       expect{Lodging.create_rooms(3.5)}.must_raise ArgumentError
#     end
#   end
# end
