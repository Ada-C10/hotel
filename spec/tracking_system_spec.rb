require_relative 'spec_helper'
require_relative '../lib/tracking_system'
require_relative '../lib/room'
require_relative '../lib/reservation'
require 'pry'

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

  describe "#add_reservation" do
    before do
      @tracker = TrackingSystem.new
      # @room = Room.new({room_num: 1, availability: :available })
    end

    it "returns an array of reservations" do
      @reservations = @tracker.add_reservation(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), number_of_rooms:1)
      @reservations = @tracker.add_reservation(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), number_of_rooms:6)
      list = @tracker.reservations
      expect(@reservations).must_be_kind_of Array
    end

    it "raises ArgumentError if there are not enough available-rooms on the requested date" do
      expect{@tracker.add_reservation(start_time: Date.new(2018,1,1),end_time:Date.new(2018,1,2),number_of_rooms:350)}.must_raise ArgumentError
    end

    it "increases the number of reservations in the reservations list" do
      @reservations = @tracker.add_reservation(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), number_of_rooms:1)
      original_num_of_reservations = @tracker.reservations
      @reservations = @tracker.add_reservation(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), number_of_rooms:1)
      updated_num_of_reservations = @tracker.reservations
      expect(updated_num_of_reservations.length).must_equal 2
    end
  end #end of describe






  # @reservation = @tracker.add_reservation(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), number_of_rooms:1)
  # #check the length of reservations
  # updated_num_of_reservations = @tracker.reservations.length
  # # #make another reservation
  # # @reservation2 = @tracker.add_reservation(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,2), number_of_rooms:1)
  # # #check the length and the compare them
  # # updated_num_of_reservations = @tracker.reservations.length
  # # # binding.pry



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
  #   @reservation = @tracker.add_reservation(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), rooms: 1) #<---1 is the number of rooms
  #
  #   expect(@reservation).must_be_kind_of Reservation
  # end



  describe "#view_available_rooms_on specifc date range" do
    before do
      @tracker = TrackingSystem.new
    end

    it "returns an array" do
      @tracker = TrackingSystem.new
      @available_rooms = @tracker.view_available_rooms_on(start_time: Date.new(2018,8,1),end_time:Date.new(2018,9,5))
      expect(@available_rooms).must_be_kind_of Array
    end

    it "returns an array containing instances of Room" do
      @tracker = TrackingSystem.new
      @available_rooms = @tracker.view_available_rooms_on(start_time: Date.new(2018,8,1),end_time:Date.new(2018,9,5))
      expect(@available_rooms[0]).must_be_kind_of Room
    end

    it "raises ArgumentError if no rooms are available on these dates" do
      @tracker = TrackingSystem.new
      @tracker.all_rooms.each do |room|
        room.reserved_dates << {start_time: Date.new(2018,1,1), end_time: Date.new(2018,1,2)}
      end
      #need to create add_reservation and then call it 20 times on the same date then the 21st time it'll raise an error
      expect{@tracker.view_available_rooms_on(start_time: Date.new(2018,1,1),end_time:Date.new(2018,1,2))}.must_raise ArgumentError
    end

    it "raises ArgumentError if start_time is > end_time" do
      @tracker = TrackingSystem.new
      expect{@tracker.view_available_rooms_on(start_time: Date.new(2018,10,5),end_time:Date.new(2018,9,5))}.must_raise ArgumentError
    end

  end



  describe "#view_reservations_on" do
    before do
      @tracker = TrackingSystem.new
    end

    it "returns an array" do
      @reservation = @tracker.add_reservation(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:1)
      @reservation1 = @tracker.add_reservation(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:1)
      expect(@tracker.view_reservations_on(Date.new(2018,10,5))).must_be_kind_of Array
    end

    it "raises an ArgumentError if no reservations are available on given date" do
      expect{@tracker.view_reservations_on(Date.new(3333,10,5))}.must_raise ArgumentError
    end

    it "raises an ArgumentError if given date is not an instance of Date class" do
      expect{@tracker.view_reservations_on(2018,2,1)}.must_raise ArgumentError
    end
  end


  describe "#total_cost_of_reservation" do
    before do
      @tracker = TrackingSystem.new
      attributes = {room_num: 1 ,start_time: Date.new(2018,8,1),end_time: Date.new(2018,9,1),price: 200.00}
      @reservation = Reservation.new(attributes)
    end

    it "raises ArgumentError unless argument is an instance of Reservation" do
      expect{@tracker.total_cost_of_reservation("hello there!")}.must_raise ArgumentError
    end

    it "returns an instance of a Float" do
      expect(@tracker.total_cost_of_reservation(@reservation)).must_be_kind_of Float
    end

    it "returns a postive number" do
      expect(@tracker.total_cost_of_reservation(@reservation)).must_equal 6200.00
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
