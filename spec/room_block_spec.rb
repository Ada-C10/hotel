require_relative 'spec_helper.rb'

describe 'Wave 3' do
  before do
    @hotel = BookingLogic::RoomBooker.new

    room_id1 = 14
    @check_in1 = Date.new(2018, 4, 1)
    check_out1 = Date.new(2018, 4, 2)
    @reservation1 = @hotel.new_reservation(room_id1, @check_in1, check_out1)

    room_id2 = 15
    check_in2 = Date.new(2018, 4, 3)
    @check_out2 = Date.new(2018, 4, 6)
    @reservation2 = @hotel.new_reservation(room_id2, check_in2, @check_out2)

    @name = "Gay Convention"
    @room_rate = 160
    @number_of_rooms = 5
    @room_block = @hotel.new_room_block(@name, @check_in1, @check_out2, @number_of_rooms, @room_rate)
  end
  
  describe 'Can create a new RoomBlock' do
    it 'creates a new RoomBlock when RoomBlock.new is called' do
      expect(@room_block).must_be_instance_of BookingLogic::RoomBlock

      # The following assertions based off of provided arguments in before block
      expect(@room_block.check_in).must_equal @check_in1
      expect(@room_block.check_out).must_equal @check_out2
      expect(@room_block.rooms.length).must_equal @number_of_rooms
      expect(@room_block.rate).must_equal @room_rate
    end
  end
end
