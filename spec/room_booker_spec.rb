require_relative 'spec_helper.rb'

describe 'Wave 1' do
  describe 'list_rooms method' do
    it 'lists all rooms in the hotel' do
      hotel = BookingLogic::RoomBooker.new

      expect(hotel.list_rooms).must_be_kind_of Array
      expect(hotel.list_rooms.length).must_equal 20
    end
  end


end
