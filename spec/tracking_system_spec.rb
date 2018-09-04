require_relative 'spec_helper'
require_relative '../lib/tracking_system'
require_relative '../lib/room'
require_relative '../lib/reservation'


# Wave 1 Tracking Reservations
# 1. access the list of all of the rooms in the hotel
# 2. reserve a room for a given date range
# 3. access the list of reservations for a specific date
# 4. get the total cost for a given reservation
#
#NOTES ON POSSIBLE TESTS TO ADD:
#making sure each instance variable in initialization is the correct class

describe 'TrackingSystem class' do

  describe "#initialize" do
    before do
      @tracker = TrackingSystem.new
    end

    it 'is an instance of TrackingSystem' do
      expect(@tracker).must_be_kind_of TrackingSystem
    end

    it 'has a list of available rooms' do
      expect(@tracker.available_rooms).must_be_instance_of Array
    end

    it 'has a list of unavailable rooms' do
      expect(@tracker.unavailable_rooms).must_be_instance_of Array
    end

    it 'has a list of all rooms' do
      expect(@tracker.all_rooms).must_be_instance_of Array
    end

  end

  #method for making a reservation
  # Admin can reserve a room for a given date range
  describe "#make_reservation" do
    before do
      @room = Room.new({room_num: 1, price: 200.0, availability: :available })
    end

    it "creates a new instance of Reservation" do
      expect(@room.make_reservation(checkin_time: Date.new(2018,8,1), checkout_time: Date.new(2018,8,25))).must_be_kind_of Reservation
    end

    # it "changes availability to :unavailable for a given date range" do
    # end
  end
end #end of class method
