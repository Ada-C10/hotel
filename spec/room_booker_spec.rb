require_relative 'spec_helper'

describe "RoomBooker Class" do
  before do
    @date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
    @reservation_1 = Hotel::RoomBooker.new()
    @reservation_1.make_reservation(@date_range_1)
  end


  describe "Initializer" do
    it 'Creates an array of room numbers' do
      expect(@reservation_1.room).must_be_kind_of Array
    end

    it 'Creates an array of reservation instances' do
      expect(@reservation_1.reservations[0]).must_be_kind_of Hotel::Reservation
    end
  end

  describe "list_rooms method" do
    it 'Returns an array of room numbers' do
      expect(@reservation_1.list_rooms).must_be_kind_of Array
    end
  end



end
