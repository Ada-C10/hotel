require_relative 'spec_helper'

describe "HotelManager" do
  let (:my_hotel) {
    Hotel::HotelManager.new
  }
  let (:start_date) {
    "2018-10-07"
  }
  let (:end_date) {
    "2018-10-16"
  }

  describe "#initialize" do
    it "Creates an instance of Hotel Manager" do
      expect(my_hotel).must_be_kind_of Hotel::HotelManager
    end

    it "establishes the base data structures when instantiated" do
      [:rooms, :reservations].each do |prop|
        expect(my_hotel).must_respond_to prop
      end

      expect(my_hotel.rooms).must_be_kind_of Array
      expect(my_hotel.reservations).must_be_kind_of Array
    end

    it "Keeps track of rooms" do
      my_hotel.rooms.each_with_index do |room, i|
        expect(room.id).must_equal (i + 1)
        expect(room).must_be_kind_of Hotel::Room
      end
    end

    it "Keeps track of reservations" do
      my_hotel.reservations.each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Reservation
      end
    end

    it "Keeps track of blocks" do
      my_hotel.blocks.each do |block|
        expect(block).must_be_kind_of Hotel::Block
      end
    end
  end

  describe "#make_reservation" do
    it "Creates a reservation for a room in a new block" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date, group_name: "Puzzled Pint People")

      expect(my_hotel.reservations.last.group_name).must_equal "Puzzled Pint People"
    end

    it "Creates a reservation for a room in an existing block" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date, group_name: "NCTM")

      expect(my_hotel.reservations.last.group_name).must_equal "NCTM"
    end

    it "Allows a reservation to be created on the same day another party checks out" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      expect(my_hotel.reservations.last.room_number).must_equal 1

      my_hotel.make_reservation(start_date: "2018-10-16", end_date: "2018-10-18")
      expect(my_hotel.reservations.last.room_number).must_equal 1
    end

    it "Does not allow a reservation to be created when dates overlap in the back for the same room" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      expect(my_hotel.reservations.last.room_number).must_equal 1

      my_hotel.make_reservation(start_date: "2018-10-08", end_date: "2018-10-18")
      expect(my_hotel.reservations.last.room_number).wont_equal 1
    end

    it "Does not allow a reservation to be created when dates overlap in the front for the same room" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      expect(my_hotel.reservations.last.room_number).must_equal 1

      my_hotel.make_reservation(start_date: "2018-10-01", end_date: "2018-10-08")
      expect(my_hotel.reservations.last.room_number).wont_equal 1
    end

    it "Does not allow a reservation to be created when dates are completely contained for the same room" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      expect(my_hotel.reservations.last.room_number).must_equal 1

      my_hotel.make_reservation(start_date: "2018-10-08", end_date: "2018-10-10")
      expect(my_hotel.reservations.last.room_number).wont_equal 1
    end

    it "Does not allow a reservation to be created when dates are completely containing for the same room" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      expect(my_hotel.reservations.last.room_number).must_equal 1

      my_hotel.make_reservation(start_date: "2018-10-03", end_date: "2018-10-18")
      expect(my_hotel.reservations.last.room_number).wont_equal 1
    end

    it "Does not allow a reservation to be created when dates are the same for the same room" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      expect(my_hotel.reservations.last.room_number).must_equal 1

      my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      expect(my_hotel.reservations.last.room_number).wont_equal 1
    end

    it "Updates all reservations by creating a Reservation" do
      my_hotel.make_reservation(start_date: start_date, end_date: end_date)

      expect(my_hotel.reservations.last.start_date).must_equal Date.parse(start_date)
      expect(my_hotel.reservations.last.end_date).must_equal Date.parse(end_date)
    end

    it "Creates and stores a reservation when there are no reservations yet" do
      my_reservations = my_hotel.reservations.clear

      my_hotel.make_reservation(start_date: start_date, end_date: end_date)

      expect(my_reservations.length).must_equal 1
      expect(my_reservations.first.room_number).must_equal 1
      expect(my_reservations.first.start_date).must_equal Date.parse(start_date)
      expect(my_reservations.first.end_date).must_equal Date.parse(end_date)
    end

    it "Raises an error if no rooms are available for a specific date" do
      20.times do
        my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      end

      expect {
        my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      }.must_raise ArgumentError
    end

    it "Raises an error if not enough rooms are available for a specific date" do
      15.times do
        my_hotel.make_reservation(start_date: start_date, end_date: end_date)
      end

      expect {
        my_hotel.make_reservation(start_date: start_date, end_date: end_date, num_of_rooms: 6)
      }.must_raise StandardError
    end

    it "Raises an error if not enough rooms are available in the block for a specific date" do
      5.times do
        my_hotel.make_reservation(start_date: start_date, end_date: end_date, group_name: "A Whole New World")
      end

      expect {
        my_hotel.make_reservation(start_date: start_date, end_date: end_date, group_name: "A Whole New World")
      }.must_raise StandardError
    end

    it "Creates a new block for the same group if booked with new dates" do
      nctm_block = Hotel::Block.find_block(my_hotel.blocks, "NCTM")

      my_hotel.make_reservation(start_date: "2019-06-15", end_date: "2019-06-18", group_name: "NCTM")


      expect(my_hotel.blocks.last).wont_equal nctm_block
    end

    it "Updates existing block for a group if booked with same dates" do
      4.times do
        my_hotel.make_reservation(start_date: "2019-02-21", end_date: "2019-02-25", group_name: "NCTM")
      end

      nctm_block = Hotel::Block.find_block(my_hotel.blocks, "NCTM", start_date: "2019-02-21", end_date: "2019-02-25")

      nctm_block.room_list.each do |room_num, status|
        expect(status).must_equal :UNAVAILABLE
      end
    end
  end

  describe "#create_a_block" do
    before do
      @group_name = "Euchre Team"
      @num_of_rooms = 3
      @start_date = "2018-12-10"
      @end_date = "2018-12-12"
      @room_rate = 145
    end

    it "Creates an instance of block" do
      my_hotel.create_a_block(@group_name, num_of_rooms: @num_of_rooms, start_date: @start_date, end_date: @end_date, room_rate: @room_rate)

      expect(my_hotel.blocks.last).must_be_kind_of Hotel::Block
      expect(my_hotel.blocks.last.group_name).must_equal @group_name
      expect(my_hotel.blocks.last.room_list).must_be_kind_of Hash
      expect(my_hotel.blocks.last.room_list.length).must_equal @num_of_rooms
      expect(my_hotel.blocks.last.room_rate).must_equal @room_rate
    end

    it "Raises an error if block num_of_rooms is greater than 5" do
      expect {
        my_hotel.create_a_block(@group_name, num_of_rooms: 7, start_date: @start_date, end_date: @end_date, room_rate: @room_rate)
      }.must_raise ArgumentError
    end

    it "Raises an error if no rooms are available for the block" do
      my_hotel.rooms.length.times do |i|
        Hotel::Room.change_status_of_room(my_hotel.rooms, i+1, start_date: @start_date, end_date: @end_date)
      end

      expect{
        my_hotel.create_a_block(@group_name, num_of_rooms: 3, start_date: @start_date, end_date: @end_date)
      }.must_raise ArgumentError
    end

    it "Raises an error if not enough rooms are available for the block" do
      19.times do |i|
        Hotel::Room.change_status_of_room(my_hotel.rooms, i+1, start_date: @start_date, end_date: @end_date)
      end

      expect{
        my_hotel.create_a_block(@group_name, num_of_rooms: 3, start_date: @start_date, end_date: @end_date)
      }.must_raise ArgumentError
    end
  end

  describe "#find_reservations" do
    before do
      @date = "2018-12-05"
    end

    it "Returns an array" do
      reservations = my_hotel.find_reservations(date: @date)

      expect(reservations).must_be_kind_of Array
    end

    it "Returns an accurate count of Reservations" do
      reservations = my_hotel.find_reservations(date: @date)

      expect(reservations.length).must_equal 2
    end
  end

  describe "#find_available_rooms" do
    it "Returns an array of all available rooms for a given date range" do
      list = my_hotel.find_available_rooms(my_hotel.rooms, start_date: "2019-01-13", end_date: "2019-01-15")

      expect(list.length).must_equal 18
      expect(list).must_be_kind_of Array
    end
  end

  describe "#find_all_available_rooms_in_block" do
    it "Returns an array of all available rooms in a given block" do
      list = my_hotel.find_available_rooms_in_block(my_hotel.blocks, "AdaC10", start_date: "2019-03-02", end_date: "2019-03-05")

      expect(list.length).must_equal 2
      expect(list).must_be_kind_of Array
    end
  end

  describe "#load_rooms and #load_reservations" do
    it "accurately loads room information into rooms array" do
      first_room = my_hotel.rooms.first
      last_room = my_hotel.rooms.last

      expect(first_room.id).must_equal 1
      expect(last_room.id).must_equal 20
      expect(first_room.status_by_date).must_be_kind_of Hash
    end

    it "accurately loads reservation information into reservation array" do
      first_rv = my_hotel.reservations.first
      last_rv = my_hotel.reservations.last

      expect(first_rv.room_number).must_equal 1
      expect(last_rv.room_number).must_equal 18
    end

    it "accurately updates Rooms when Reservations are added" do
      my_reservation = my_hotel.reservations.first
      my_room = my_hotel.rooms.find {|r| r.id == my_reservation.room_number}

      (my_reservation.start_date...my_reservation.end_date).each do |date|
        expect(my_room.status_by_date[date]).must_equal :UNAVAILABLE
      end
    end
  end

  describe "#load_blocks" do
    before do
      @first_block = my_hotel.blocks.first
      @last_block = my_hotel.blocks.last
    end

    it "accurately loads block information into blocks array" do
      expect(@first_block.group_name).must_equal "Comic-Con"
      expect(@last_block.group_name).must_equal "UC Berkeley"
    end

    it "Checks that rooms in block are unavailable to the public" do
      my_room = my_hotel.rooms.find {|r| r.id == @first_block.room_list.keys[0]}
      second_room = my_hotel.rooms.find {|r| r.id == @last_block.room_list.keys[0]}

      first_start_date = Date.parse(@first_block.start_date)
      second_start_date = Date.parse(@last_block.start_date)

      expect(my_room.status_by_date[first_start_date]).must_equal :UNAVAILABLE
      expect(second_room.status_by_date[second_start_date]).must_equal :UNAVAILABLE
    end

    it "Checks that rooms in block are available for private guests" do
      room_availability = @first_block.room_list.values[0]
      second_room_availability = @last_block.room_list.values[0]

      expect(room_availability).must_equal :AVAILABLE
      expect(second_room_availability).must_equal :AVAILABLE
    end
  end
end
