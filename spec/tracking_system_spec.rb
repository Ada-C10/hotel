require_relative 'spec_helper'
require_relative '../lib/tracking_system'
require_relative '../lib/room'
require_relative '../lib/reservation'
require 'pry'


# Wave 1 Tracking Reservations
# 1. access the list of all of the rooms in the hotel
# 2. reserve a room for a given date range
# 3. access the list of reservations for a specific date
# 4. get the total cost for a given reservation
#
#NOTES ON POSSIBLE TESTS TO ADD:
#making sure each instance variable in initialization is the correct class

describe 'TrackingSystem class' do
  ###### WAVE 1 ##################################################################
  describe "#initialize" do
    before do
      @tracker = TrackingSystem.new
      # @tracker.all_rooms.each do |room| room.reserved_dates << {checkin_time: Date.new(2018,8,1), checkout_time: Date.new(2018,8,5)}
      end

      it 'is an instance of TrackingSystem' do
        expect(@tracker).must_be_kind_of TrackingSystem
      end

      it 'has a list of all rooms' do
        expect(@tracker.all_rooms).must_be_instance_of Array
      end

      it 'has a list of reservations' do
        expect(@tracker.reservations).must_be_instance_of Array
      end

    end

    describe "access the list of all 20 rooms in the hotel" do
      before do
        @tracker = TrackingSystem.new
      end

      it 'must return an Array' do
        expect(@tracker.all_rooms).must_be_instance_of Array
      end

      it 'must contain 20 elements' do
        expect(@tracker.all_rooms.length).must_equal 20
      end

      it 'must contain only instances of Room' do
        expect(@tracker.all_rooms.all? {|room| room.class == Room}).must_equal true
      end
    end

    # #method for making a reservation
    # # Admin can reserve a room for a given date range
    describe "#make_reservation" do
      before do
        @tracker = TrackingSystem.new
        # @room = Room.new({room_num: 1, availability: :available })
      end

      it "creates a new instance of Reservation" do
        @reservation = @tracker.make_reservation(Date.new(2018,8,1), Date.new(2018,8,25), 1) #<---1 is the number of rooms
        # binding.pry
        expect(@reservation).must_be_kind_of Reservation
      end

      # it "increases the number of reservations in the reservations list" do
      #   num_of_reservations = @tracker.reservations.length
      #   @reservation = @tracker.make_reservation(Date.new(2018,8,1),Date.new(2018,8,25),1)
      #   @reservation2 = @tracker.make_reservation(Date.new(2018,8,1),Date.new(2018,8,25),1)
      #   updated_num_of_reservations = @tracker.reservations.length
      #   binding.pry
      #   expect(updated_num_of_reservations - num_of_reservations).must_equal 1
      # end

      # it "changes block_status of the reserved room to :RESERVED for a given date range" do
      # end
      # it "saves the checkout_time as a day before " do
      # end
      # it "adds a hash of start/end time to each room.reserved_dates array" do
      # end

      # it "only selects rooms that are available  " do
      #   expect(@reservation.)
      # end
      #
      # it "creates reservations for the number_of_rooms requested " do
      # end
      #
      # it "iterates through @all_rooms to find the first available rooms" do
      # end
      #
      # it "raises ArgumentError if inside @all_rooms no room is available on this date range" do
      # end
      #
      # it "creates a new instance of Reservation" do
      #   @reservation = @tracker.make_reservation(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), rooms: 1) #<---1 is the number of rooms
      #
      #   expect(@reservation).must_be_kind_of Reservation
      # end

    end

    # def make_reservation(start_time: nil, end_time: nil, number_of_rooms)
    #   # 1. pick a room that is available. the next available room?
    #   @all_rooms.each do |room|
    #     room.reserved_dates.each do |reserved_dates| # this is a hash containing {checkin_time: checkin, checkout_time: checkout}, can replace some fo this with helper method
    #       if !(reserved_dates[:start_time]..reserved_dates[:end_time]).include?(:checkin) && room.block == :NA
    #         #create a new reservation with |room| that is iterated in and fits the reqs
    #       else
    #        # raise argument error if inside @all_rooms no room is available on this date range (then admin would need to input a new date range)
    #   # else..make the new reservation below
    #   reservation = Reservation.new(date_range: view_two_dates_as_range {start_time: checkin, end_time: checkout -1}, room: room)  # <----room object contains {room_num:, price: STANDARD_ROOM_PRICE, customer: ""}
    #   @reservations << reservation
    #   room.reserved_dates << {start_time: checkin, end_time: checkout}
    # end
    # def view_available_rooms_on(start_time, end_time)
    #   #available_rooms = []
    #   # @all_rooms.each do |room|
    #   # room.reserved_dates.each do |date_range| <---date_range could be a hash like {checkin_time: checkin, checkout_time: checkout}
    #   ###  if the date_range doesn't include date aka:
    #   # if !date_range.include?(date)
    #   # available_rooms << room
    #   # end
    #   # return available_rooms (this is an array of rooms avail on 'date' passed as param)
    #
    describe "#view_available_rooms_on specifc date range" do
      before do
      end

      it "returns an array" do
        @tracker = TrackingSystem.new
        @available_rooms = @tracker.view_available_rooms_on(start_time: Date.new(2018,8,1),end_time:Date.new(2018,9,5))
        expect(@available_rooms).must_be_kind_of Array
        # binding.pry
      end

      it "raises ArgumentError if start_time is > end_time" do
        @tracker = TrackingSystem.new
        expect{@tracker.view_available_rooms_on(start_time: Date.new(2018,10,5),end_time:Date.new(2018,9,5))}.must_raise ArgumentError
      end

    end






    describe "#view_all_rooms" do
      before do
        @tracker = TrackingSystem.new
      end

      it "returns a list" do
        expect(@tracker.view_all_rooms).must_be_kind_of Array
      end

    end

  end #end of class method
