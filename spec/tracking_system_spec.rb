require_relative 'spec_helper'
require_relative '../lib/tracking_system'
require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/block'
require 'pry'

describe 'TrackingSystem class' do
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

    it 'has a list of blocks' do
      expect(@tracker.blocks).must_be_instance_of Array
    end

  end


  describe "#view_all_rooms" do
    before do
      @tracker = TrackingSystem.new
    end

    it "returns a list" do
      expect(@tracker.view_all_rooms).must_be_kind_of Array
    end

    it 'must contain 20 elements' do
      expect(@tracker.view_all_rooms.length).must_equal 20
    end

    it 'must contain only instances of Room' do
      expect(@tracker.view_all_rooms.all? {|room| room.class == Room}).must_equal true
    end
  end


  describe "#view_reservations_on(date)" do
    before do
      @tracker = TrackingSystem.new
    end

    it "returns an array" do
      @reservation = @tracker.add_reservation(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:1)
      @reservation1 = @tracker.add_reservation(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:1)
      expect(@tracker.view_reservations_on(Date.new(2018,10,5))).must_be_kind_of Array
    end
    #this one is working 3333,10,5
    it "raises an ArgumentError if no reservations are available on given date" do
      expect{@tracker.view_reservations_on(Date.new(3333,10,5))}.must_raise ArgumentError
    end
    #this one is not working!!!!!!
    it "raises an ArgumentError if given date is not an instance of Date class" do
      expect{@tracker.view_reservations_on("some date")}.must_raise ArgumentError
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


  describe "#view_available_rooms_on" do
    before do
      @tracker = TrackingSystem.new
    end

    it "raises ArgumentError if start_time is > end_time" do
      @tracker = TrackingSystem.new
      expect{@tracker.view_available_rooms_on(start_time: Date.new(2018,10,5),end_time:Date.new(2018,9,5))}.must_raise ArgumentError
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

    it "raises ArgumentError if no rooms are available on these dates(aka they're in a block or reserved)" do
      @tracker = TrackingSystem.new
      @tracker.all_rooms.each do |room|
        room.reserved_dates << {start_time: Date.new(2018,1,1), end_time: Date.new(2018,1,2)}
      end
      expect{@tracker.view_available_rooms_on(start_time: Date.new(2018,1,1),end_time:Date.new(2018,1,2))}.must_raise ArgumentError
    end

    # it "ensures rooms returned aren't in a block" do
    #   #make a new block for that date, reserve rooms that are in that block,
    #   # then call view_availa rooms on that date
    #   @tracker.add_block(start_time: Date.new(2018,1,1), end_time: Date.new(2018,1,29), number_of_rooms: 5, discount: 10)
    #   block_id = @tracker.blocks[0].block
    #   @tracker.add_reservation_in_block(start_time: Date.new(2018,1,1), end_time: Date.new(2018,1,29), number_of_rooms: 5, block: block_id)
    #   available_rooms = @tracker.view_available_rooms_on(start_time: Date.new(2018,1,1), end_time: Date.new(2018,1,29))
    #   binding.pry
    # end

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






  describe "#add_block" do
    before do
      @tracker = TrackingSystem.new
    end

    #this test is always passing no matter what, its not working
    # it "raises ArgumentError if discount-rate is not an Integer" do
    #   expect{@tracker.add_block(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,5), rooms: 1, discount: "hi")}.must_raise ArgumentError
    # end
    #
    # it "raises ArgumentError if rooms > 5 or <= 1" do
    #   @tracker = TrackingSystem.new
    #   expect{@tracker.add_block(start_time: Date.new(2018,8,5),end_time:Date.new(2018,9,5), rooms: 20, discount: 10)}.must_raise ArgumentError
    # end

    it "returns an array of blocks" do
      @block = @tracker.add_block(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), number_of_rooms:5)
      @block = @tracker.add_block(start_time: Date.new(2018,7,1), end_time: Date.new(2018,7,10), number_of_rooms:4)
      # binding.pry
      expect(@tracker.blocks).must_be_kind_of Array
    end

    it "raises ArgumentError if start_time is > end_time" do
      @tracker = TrackingSystem.new
      expect{@tracker.add_block(start_time: Date.new(2018,10,5),end_time:Date.new(2018,9,5))}.must_raise ArgumentError
    end

    it "modifys each room's block id to the same block id as its Block" do
      @block = @tracker.add_block(start_time: Date.new(2018,8,1), end_time: Date.new(2018,8,25), number_of_rooms:5)
      @blockid = @tracker.blocks[0].block
      @room_block = @tracker.blocks[0].rooms[0].block
      expect(@blockid == @room_block).must_equal true
    end
  end


  describe "#rooms_available_in_block" do
    before do
      @tracker = TrackingSystem.new
      @block = @tracker.add_block(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:5)
      @blockid = @tracker.blocks[0].block
    end

    it "returns list of rooms that are available in a block" do
      @reservation1 = @tracker.add_reservation(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:1)
      @reservation2 = @tracker.add_reservation(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:1)
      @reservation3 = @tracker.add_reservation(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:1)
      expect(@tracker.rooms_available_in_block(@blockid)).must_be_kind_of Array
    end

    it "raises ArgumentError unless argument is instance of Symbol" do
      expect{@tracker.rooms_available_in_block("Hi")}.must_raise ArgumentError
    end
  end

  describe "#add_reservation_in_block" do
    before do
      @tracker = TrackingSystem.new
      @block = @tracker.add_block(start_time: Date.new(2018,10,5), end_time: Date.new(2018,10,10), number_of_rooms:5)
      @blockid = @tracker.blocks[0].block
    end

    it "Adds a reservation to each room's list of reservations" do
      # expect(@tracker.add_reservation_in_block)
    end
  end

  describe "#retrieve_block_dates" do
    before do
      @tracker = TrackingSystem.new
      @block = @tracker.add_block(start_time: Date.new(2018,7,5), end_time: Date.new(2018,7,10), number_of_rooms:5)

    end

    it "returns the date range as an Array " do
      @blockid = @tracker.blocks[0].block
      @date_range = @tracker.retrieve_block_dates(@blockid)
      expect(@date_range).must_be_kind_of Array
    end

    it "returns date range that excludes the end date " do
      @blockid = @tracker.blocks[0].block
      @date_range = @tracker.retrieve_block_dates(@blockid)
      expect(@date_range.last).must_equal Date.new(2018,7,9)
    end

#this isn't working either, can't figure out how to make it fail when it should
    it "raises ArgumentError unless argument is a Symbol" do
      expect{@tracker.retrieve_block_dates("hello")}.must_raise ArgumentError
    end
    # def retrieve_block_dates(block_id)
    #   dates_hash = {}
    #   range_array = []
    #   @blocks.each do |block|
    #     if block.block == block_id
    #       dates_hash[:start_time] = block.start_time
    #       dates_hash[:end_time] = block.end_time
    #       range_array = (dates_hash[:start_time]...dates_hash[:end_time]).to_a
    #     end
    #   end
    #   raise ArgumentError if dates_hash.empty?
    #   return range_array #returns array of teh date range
    # end
  end



  describe "#retrieve_block_discount" do
    it "returns a block's discount rate" do

    end

    it "raises ArgumentError unless argument is a Symbol" do
    end
  end





end #end of class method


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
