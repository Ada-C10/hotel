require_relative 'spec_helper'
require 'date'
require 'pry'

describe "BookingSystem class" do

  before do
    @system = Hotel::BookingSystem.new
  end

  describe "load rooms" do
    it "loads rooms in an array" do
      @rooms = @system.load_rooms
      # binding.pry
      expect(@rooms).must_be_kind_of Array
    end
  end

  describe "make reservation" do
    it "makes a reservation" do
      @system.make_reservation(Date.new(2018,1,1), Date.new(2018,1,5))
      reservation = Hotel::Reservation.new(reservation_id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      expect(@system.reservations.length).must_equal 1
    end

  end

  describe "assign room" do
    it "assigns the first available room" do

      # @system.make_reservation(Date.new(2018, 1, 1), Date.new(2018, 1, 5))

      reservation1 = Hotel::Reservation.new(reservation_id: 1, room: 1, start_date: Date.new(2018, 1, 7), end_date: Date.new(2018, 1, 8), price_per_night: 200)
      @system.reservations << reservation1

      # @system.make_reservation(Date.new(2018, 1, 6), Date.new(2018, 1, 7))

      reservation2 = Hotel::Reservation.new(reservation_id: 2, room: 2, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation2


      reservation3 = Hotel::Reservation.new(reservation_id: 3, room: @system.assign_available_room(Date.new(2018, 1, 6), Date.new(2018, 1, 9)), start_date: Date.new(2018, 1, 6), end_date: Date.new(2018, 1, 9), price_per_night: 200)
      @system.reservations << reservation3
      expect(reservation3.room).must_equal 2
    end
  end

  describe "search reservation dates" do
    before do

      reservation1 = Hotel::Reservation.new(reservation_id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 8), price_per_night: 200)
      @system.reservations << reservation1

      reservation2 = Hotel::Reservation.new(reservation_id: 2, room: 2, start_date: Date.new(2018, 1, 7), end_date: Date.new(2018, 1, 15), price_per_night: 200)
      @system.reservations << reservation2

    end
    it "returns an array of reservations" do

      expect(@system.search_reservations(Date.new(2018, 1, 4), Date.new(2018, 1, 8))).must_be_instance_of Array
    end

    it "returns reservations that overlap on the existing reservation start date" do

      expect(@system.search_reservations(Date.new(2017, 12, 30), Date.new(2018, 1, 5))[0].reservation_id).must_equal 1

    end

    it "returns reservations that overlap on the existing reservation end" do

      expect(@system.search_reservations(Date.new(2018, 1, 10), Date.new(2018, 1, 20))[0].reservation_id).must_equal 2

    end

    it "returns multiple reservations that are on the same date" do

      expect(@system.search_reservations(Date.new(2018, 1, 7), Date.new(2018, 1, 15)).length).must_equal 2

    end

    it "does not return reservations that end on the new reservation's start date" do

      expect(@system.search_reservations(Date.new(2018, 1, 15), Date.new(2018, 1, 20)).length).must_equal 0

    end

    it "does not return reservations that start on the new reservation's end date" do

      expect(@system.search_reservations(Date.new(2017, 12, 20), Date.new(2018, 1, 1)).length).must_equal 0

    end

  end

  describe "find reservation method with reservation_id" do
    it "returns the corresponding reservation given reservation_id" do
      reservation = Hotel::Reservation.new(reservation_id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation

      expect(@system.find_reservation(1))[0].reservation_id.must_equal 1
    end
  end

  describe "total cost of reservation" do
    it "finds the total cost of reservation given reservation_id" do

      reservation = Hotel::Reservation.new(reservation_id: 1, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation

      expect(@system.total_cost(1)).must_equal 800
    end
  end

  describe "generate_id" do
    it "generates an integer reservation_id" do
      expect(@system.generate_id).must_be_kind_of Integer
    end

    it "assigns reservation_id to reservation" do
      reservation1 = Hotel::Reservation.new(reservation_id: @system.generate_id, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation1

      expect(reservation1.reservation_id).must_be_kind_of Integer
    end

    it "raises an Argument Error if reservation_id is not unique" do
      # binding.pry
      reservation1 = Hotel::Reservation.new(reservation_id: @system.generate_id, room: 1, start_date: Date.new(2018, 1, 1), end_date: Date.new(2018, 1, 5), price_per_night: 200)
      @system.reservations << reservation1
      expect { @system.check_id(reservation1.reservation_id) }.must_raise ArgumentError
    end
  end

  describe "block tests" do
    describe "make_block method" do
      it "raises ArgumentError if more than 5 rooms booked" do
        expect { @system.make_block((Date.new(2018, 1, 1)), (Date.new(2018, 1, 2)), 6) }.must_raise ArgumentError
      end

      it "creates a block" do
        @system.make_block((Date.new(2018,1,1)), (Date.new(2018,1,5)), 5)

        expect(@system.blocks.length).must_equal 1
      end

      it "creates x number of reservations for x rooms in the block (x = 5)" do
        @system.make_block((Date.new(2018,1,1)), (Date.new(2018,1,5)), 5)

        expect(@system.reservations.length).must_equal 5
      end
    end

    describe "find_empty_block_reservation" do
      it "finds an empty block reservation given the block id" do
        block_reservation = Hotel::BlockReservation.new(block_id: 20,  reservation_id: nil, room: 2, start_date: Date.new(2018,1,1), end_date: Date.new(2018,1,5), price_per_night: 150)
        @system.reservations << block_reservation

        expect(@system.find_empty_block_reservation(20)).must_equal block_reservation
      end

      it "will raise argument error if all rooms in block have been reserved" do
        block_reservation = Hotel::BlockReservation.new(block_id: 20,  reservation_id: 5, room: 2, start_date: Date.new(2018,1,1), end_date: Date.new(2018,1,5), price_per_night: 150)
        @system.reservations << block_reservation

        expect { @system.find_empty_block_reservation(20) }.must_raise ArgumentError
      end
    end

    describe "make_block_reservation" do

      it "changes reservation_id from nil to integer when making a block_reservation" do
        block_reservation = Hotel::BlockReservation.new(block_id: 20,  reservation_id: nil, room: 2, start_date: Date.new(2018,1,1), end_date: Date.new(2018,1,5), price_per_night: 150)
        @system.reservations << block_reservation

        expect((@system.make_block_reservation(20)).reservation_id).must_be_kind_of Integer
      end
    end

    # describe "find_block" do
    #   it "finds all rooms in a block in an array" do
    #     @system.make_block((Date.new(2018,1,1)), (Date.new(2018,1,5)), 5)

  end
end


# Hi! In Edges we talked about interesting test cases for date overlaps this afternoon. Here is a full list of all the cases I’ll be looking for when I give feedback:
#
# Two date ranges *do* overlap if range A compared to range B:
# - Same dates
# - Overlaps in the front
# - Overlaps in the back
# - Completely contained
# - Completely containing
#
# Two date ranges are *not* overlapping if range A compared to range B:
# - Completely before
# - Completely after
# - Ends on the checkin date
# - Starts on the checkout date (edited)
#
#
# start1 = 9
# end1 = 12
# start2 = 8
# end2 = 15
#
# (StartDate1 < EndDate2) and (StartDate2 <= EndDate1)
#
# true true


# def search_reservations(start_date_2, end_date_2)
#   reservations_within_date = []
#   empty_rooms_within_date = []
#   @reservations.each do |reservation|
#     if
#       reservation.start_date < end_date_2 && start_date_2 < reservation.end_date
#       reservations_within_date << reservation
#     else
#       empty_rooms_within_date << reservation.room
#     end
#     # binding.pry
#   end
# end
