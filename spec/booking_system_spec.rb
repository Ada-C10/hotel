require_relative 'spec_helper'

describe "BookingSystem class" do
  let(:booking_system) {Hotel::BookingSystem.new()}

  describe "#initialize" do
    it "can create a new instance of BookingSystem" do
      expect(booking_system).must_be_kind_of Hotel::BookingSystem
    end

    it "creates accurate attribute types" do
      expect(booking_system.rooms).must_be_kind_of Array
      expect(booking_system.reservations).must_be_kind_of Array
    end
  end

  describe "#list_all_rooms" do
    let(:rooms_list) {booking_system.list_all_rooms()}

    it "can load a list of rooms" do
      expect(rooms_list).must_be_kind_of Array
    end

    it "accurately loads each instance of room as an integer" do
      rooms_list.each do |room|
        expect(room).must_be_kind_of Integer
      end
    end

    it "accurately describes first room" do
      first_room = rooms_list[0]
      expect(first_room).must_equal 1
    end

    it "accurately describes last room" do
      last_room= rooms_list[-1]
      expect(last_room).must_equal 20
    end
  end

  describe "#construct_cal_checker" do
    # see additional constructor tests in Calendar
    it "creates a new instance of Calendar" do
      booking_system.construct_cal_checker(check_in: "1990-10-01", check_out: "1990-10-15").must_be_kind_of Hotel::Calendar
    end
  end

  describe "#generate_res_id" do
    let(:second_res) {Hotel::Reservation.new(id: 2, room_num: 19, check_in: "1996-09-09", check_out: "1996-08-13")}
    let(:third_res) {Hotel::Reservation.new(id: 3, room_num: 20, check_in: "1996-10-01-", check_out: "1996-10-10")}

    it "can create ID for first reservation ID instance" do
      new_id = booking_system.generate_res_id()
      new_res = Hotel::Reservation.new(id: new_id, room_num: 16, check_in: "1996-08-01", check_out: "1996-08-03")

      booking_system.reservations << new_res

      expect(booking_system.reservations[0].id).must_equal 1
    end

    it "can generate accurate IDs when new reservations are added to reservations list" do
      first_res = Hotel::Reservation.new(id: 10, room_num: 19, check_in: "1996-09-09", check_out: "1996-09-13")
      booking_system.reservations << first_res

      new_id = booking_system.generate_res_id()
      second_res = Hotel::Reservation.new(id: new_id, room_num: 20, check_in: "1996-10-01", check_out: "1996-10-10")
      booking_system.reservations << second_res

      expect(booking_system.reservations[1].id).must_equal 11
    end
  end

  describe "#generate_block_id" do
    let(:block_1) {Hotel::RoomBlock.new(id: 2, rooms: [1,2,3], check_in: "1996-09-09", check_out: "1996-08-13")}
    let(:block_2) {Hotel::RoomBlock.new(id: 3, rooms: [1,2,3], check_in: "1996-10-01-", check_out: "1996-10-10")}

    it "can create ID for first room block ID instance" do
      new_id = booking_system.generate_block_id()
      new_block = Hotel::RoomBlock.new(id: new_id, rooms: [1,2,3], check_in: "1996-08-01", check_out: "1996-08-03")

      booking_system.room_blocks << new_block

      expect(booking_system.room_blocks[0].id).must_equal 1
    end

    it "can generate accurate IDs when new blocks are added to block list" do
      first_block = Hotel::RoomBlock.new(id: 10, rooms: [1,2,3], check_in: "1996-09-09", check_out: "1996-09-13")
      booking_system.room_blocks << first_block

      new_id = booking_system.generate_block_id()
      second_block= Hotel::RoomBlock.new(id: new_id, rooms: [1,2,3], check_in: "1996-10-01", check_out: "1996-10-10")
      booking_system.room_blocks << second_block

      expect(booking_system.room_blocks[1].id).must_equal 11
    end
  end

  describe "#list_res_for_date" do
    # see Calendar#has_date? for additional tests
    let(:res_1) {Hotel::Reservation.new(
      id: "1",
      room_num: "20",
      check_in: "2010-8-1",
      check_out: "2010-8-10"
      )}

    let(:res_2) {Hotel::Reservation.new(
      id: "2",
      room_num: "19",
      check_in: "2010-8-15",
      check_out: "2010-8-18"
      )}

    let(:res_3) {Hotel::Reservation.new(
      id: "4",
      room_num: "15",
      check_in: "2010-8-4",
      check_out: "2010-8-20"
      )}

    let(:matching_res) {booking_system.list_res_for_date("2010-8-5")}

    it "should return an array of Reservation objects" do
      booking_system.reservations.push(res_1, res_2, res_3)

      expect(matching_res).must_be_kind_of Array
      expect(matching_res[0]).must_be_kind_of Hotel::Reservation
    end

    it "accurately loads Reservation objects for specified date" do
      booking_system.reservations.push(res_1, res_2, res_3)

      expect(matching_res.length).must_equal 2
      expect(matching_res[0].id).must_equal 1
      expect(matching_res[1].id).must_equal 4
    end

    it "returns nil if no Reservations are found for specified date" do
      booking_system.reservations.push(res_1, res_2, res_3)

      matching_res = booking_system.list_res_for_date("2010-8-30")
      expect(matching_res).must_be_nil
    end
  end

  describe "#list_avail_rooms_for_range" do
    # see Calendar#overlap? for additonal tests
    let(:res_1) {Hotel::Reservation.new(
      id: "1",
      room_num: "18",
      check_in: "2010-6-15",
      check_out: "2010-6-20"
      )}

    let(:res_2) {Hotel::Reservation.new(
      id: "2",
      room_num: "19",
      check_in: "2010-7-15",
      check_out: "2010-7-20"
      )}

    let(:res_3) {Hotel::Reservation.new(
      id: "3",
      room_num: "20",
      check_in: "2010-8-15",
      check_out: "2010-8-20"
      )}

    it "returns an array of room numbers if rooms are available" do
      booking_system.reservations.push(res_1, res_2, res_3)

      avail_rooms = booking_system.list_avail_rooms_for_range(check_in: "2010-10-15", check_out: "2010-10-26")

      expect(avail_rooms).must_be_kind_of Array
      expect(avail_rooms[0]).must_be_kind_of Integer
    end

    it "accurately returns a list of available rooms by number if rooms are available" do
      booking_system.reservations.push(res_1, res_2, res_3)

      all_rooms = booking_system.rooms

      booked_rooms = [19, 20]

      avail_rooms = booking_system.list_avail_rooms_for_range(check_in: "2010-7-1", check_out: "2010-8-30")

      expect(avail_rooms.length).must_equal 18
      expect(avail_rooms).must_equal (all_rooms - booked_rooms)
    end

    it "returns nil if no rooms are available" do
      20.times do |i|
        res = Hotel::Reservation.new(id:1, room_num: i+1, check_in: "1999-1-1", check_out: "1999-12-31")
        booking_system.reservations << res
      end

      all_rooms = booking_system.rooms

      avail_rooms = booking_system.list_avail_rooms_for_range(check_in: "1999-6-1", check_out: "1999-7-1")

      expect(avail_rooms).must_be_nil
    end

    it "returns all rooms available if there are no reservations" do
      #edge case
      avail_rooms = booking_system.list_avail_rooms_for_range(check_in: "2010-8-1", check_out: "2010-8-20")

      all_rooms = (1..20).to_a

      expect(avail_rooms).must_equal all_rooms
    end

    it "can take rooms in room blocks into account" do
      block = Hotel::RoomBlock.new(id: 1, check_in: "1970-03-04", check_out: "1970-03-15", rooms: [1,2,3])
      booking_system.room_blocks << block

      all_rooms = (1..20).to_a
      booked_rooms = block.rooms

      avail_rooms = booking_system.list_avail_rooms_for_range(check_in: "1970-03-01", check_out: "1970-03-07")

      expect(avail_rooms).must_equal all_rooms - booked_rooms
    end
  end

  describe "#create_reservation" do
    it "throws an error when no rooms are available for a given date range" do
      20.times do |i|
        res = Hotel::Reservation.new(id:1, room_num: i+1, check_in: "1999-1-1", check_out: "1999-12-31")
        booking_system.reservations << res
      end

      expect {
        booking_system.create_reservation(
          check_in: "1999-7-1",
          check_out: "1999-7-4")}.must_raise StandardError
    end

    it "creates a new reservation successfully with correct data types" do
      res_1 = booking_system.create_reservation(check_in: "1992-10-15", check_out: "1992-10-25")

      expect(res_1).must_be_kind_of Hotel::Reservation
      expect(res_1.id).must_be_kind_of Integer
      expect(res_1.room_num).must_be_kind_of Integer
      expect(res_1.check_in).must_be_kind_of Date
      expect(res_1.check_out).must_be_kind_of Date
    end

    it "accurately adds information to first reservation made" do
      res_1 = booking_system.create_reservation(check_in: "1992-10-15", check_out: "1992-10-25")

      expect(res_1.id).must_equal 1
      expect(res_1.room_num).must_equal 1
      expect(res_1.check_in.strftime('%Y %b %d')).must_equal "1992 Oct 15"
      expect(res_1.check_out.strftime('%Y %b %d')).must_equal "1992 Oct 25"
    end

    it "ignores reservations for the same room room but on other dates" do
      res_1 = booking_system.create_reservation(check_in: "1992-10-15", check_out: "1992-10-25")
      res_2 = booking_system.create_reservation(check_in: "1992-11-15", check_out: "1992-11-25")

      expect(res_2.id).must_equal 2
      expect(res_2.room_num).must_equal 1
      expect(res_2.check_in.strftime('%Y %b %d')).must_equal "1992 Nov 15"
      expect(res_2.check_out.strftime('%Y %b %d')).must_equal "1992 Nov 25"
    end

    it "selects the next available room if reservation dates conflict with other reservations" do
      res_1 = booking_system.create_reservation(check_in: "1992-10-15", check_out: "1992-10-25")
      res_2 = booking_system.create_reservation(check_in: "1992-11-15", check_out: "1992-11-25")
      res_3 = booking_system.create_reservation(check_in: "1992-10-15", check_out: "1992-10-25")

      expect(res_3.id).must_equal 3
      expect(res_3.room_num).must_equal 2
      expect(res_3.check_in.strftime('%Y %b %d')).must_equal "1992 Oct 15"
      expect(res_3.check_out.strftime('%Y %b %d')).must_equal "1992 Oct 25"
    end
  end

  describe "#create_room_block" do
    let(:room_block) {booking_system.create_room_block(
      check_in: "1990-01-01",
      check_out: "1990-01-15",
      block_size: 2
      )}

    it "throws an error when no rooms are available for a given date range" do
      20.times do |i|
        res = Hotel::Reservation.new(id:1, room_num: i+1, check_in: "1999-1-1", check_out: "1999-12-31")
        booking_system.reservations << res
      end

      expect {
        booking_system.create_room_block(
          block_size: 4,
          check_in: "1999-7-1",
          check_out: "1999-7-4")}.must_raise StandardError
    end

    it "creates a block using room numbers" do
      expect(room_block).must_be_kind_of Hotel::RoomBlock
      expect(room_block.rooms).must_be_kind_of Array
      expect(room_block.rooms.length).must_equal 2
      expect(room_block.rooms[0]).must_be_kind_of Integer
    end

    it "accurately adds information to first room block made" do
      expect(room_block.id).must_equal 1
      expect(room_block.rooms.length).must_equal 2
      expect(room_block.check_in.strftime('%Y %b %d')).must_equal "1990 Jan 01"
      expect(room_block.check_out.strftime('%Y %b %d')).must_equal "1990 Jan 15"
    end
  end
end
