require_relative 'spec_helper'

describe "RoomBooker Class" do
  let (:booking_system) { Hotel::RoomBooker.new() }

  describe "initialize" do
    it 'Creates an array of room numbers' do
      expect(booking_system.rooms).must_be_kind_of Array
    end

    it 'Creates an array of reservation instances' do
      expect(booking_system).must_be_kind_of Hotel::Reservation
    end
  end

  describe "list_rooms method" do
    it 'Returns an array of room numbers' do
      expect(booking_system.list_rooms).must_be_kind_of Array
    end
  end




end
