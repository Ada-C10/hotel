require_relative 'spec_helper'

describe "Room Booker Class" do
  describe "initialize" do
    let (:booking_system) {
      Hotel::RoomBooker.new()
    }

    it 'Creates an array of room numbers' do
      expect(booking_system.rooms).must_be_instance_of Array
    end

    it 'Creates an array of reservation instances' do
      expect(:booking_system).must_be_instance_of Hotel::Reservation 
    end



  end
end
