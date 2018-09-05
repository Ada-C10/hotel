require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/booking_system'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "BookingSystem class" do
  let(:booking_system) {Hotel::BookingSystem.new()}

# TODO test that rooms contains room obj like in load rooms
  describe "#initialize" do
    it "can create a new instance of BookingSystem" do
      expect(booking_system).must_be_kind_of Hotel::BookingSystem
      expect(booking_system.rooms).must_be_kind_of Array
      expect(booking_system.reservations).must_be_kind_of Array
    end
  end

  describe "#load_rooms" do
    let(:rooms_list) {booking_system.load_rooms()}

    it "can load a list of rooms" do
      expect(rooms_list).must_be_kind_of Array
    end

    it "accurately loads room info in array" do
      first_room = rooms_list[0]
      last_room= rooms_list[-1]

      expect(first_room).must_be_kind_of Hotel::Room
      expect(first_room.num).must_equal 1

      expect(last_room).must_be_kind_of Hotel::Room
      expect(last_room.num).must_equal 20
    end
  end

  describe "#list_all_rooms" do
    let(:all_rooms_str) {booking_system.list_all_rooms()}

    it "lists all rooms as a string" do
      beginning_text = "Here is a list of all rooms:"
      room_2 = "Room 2"

      expect(all_rooms_str).must_be_kind_of String
      expect(all_rooms_str).must_include beginning_text
      expect(all_rooms_str).must_include room_2
    end
  end

  describe "#find_room" do
    let(:room_num) {4}
    let(:room_obj) {booking_system.find_room(room_num)}

    it "finds room object by room number" do
      # num = 4
      # room_obj = booking_system.find_room(num)

      expect(room_obj).must_be_kind_of Hotel::Room
      expect(room_obj.num).must_equal room_num
    end
  end

# TODO: add create reservation method + 2nd input as room_num??
  describe "#create_reservation" do
    # TODO test that it's added to Room
    # TODO test that it's added to reservations
    # let(:room_num) {4}
    # let(:room_obj) {booking_system.find_room(room_num)}
    let(:reservation_hash) {{
      id: "5",
      room_num: "10",
      start_date: "2010-8-6",
      end_date: "2010-8-10",
      }}
    let(:new_reservation) {booking_system.create_reservation(reservation_hash)}

    it "creates a new reservation successfully" do
      expect(new_reservation).must_be_kind_of Hotel::Reservation
    end

    it "loads reservation details properly" do
      # QUESTION: should i test values or types? in rideshare, seems like mostly type was tested....
      expect(new_reservation.id).must_equal 5
      expect(new_reservation.room.num).must_equal 10
      expect(new_reservation.start_date).must_be_kind_of Date
      expect(new_reservation.end_date).must_be_kind_of Date
      expect(new_reservation.daily_rate).must_equal 200

    end
  end

  # describe "#add_reservation" do
  #   updated_reservations = booking_system.add_reservation(new_reservation)
  # end

  # describe "#load_reservations" do
  # end

  describe "#list_reservations_for_date" do
    before do

      # res_1 = Hotel::Reservation.new({
      #   id: "1",
      #   room_num: "20",
      #   start_date: "2010-8-1",
      #   end_date: "2010-8-10",
      #   })
      # res_2 = Hotel::Reservation.new({
      #   id: "2",
      #   room_num: "19",
      #   start_date: "2008-5-15",
      #   end_date: "2010-5-18",
      #   })
      # res_3 = Hotel::Reservation.new({
      #   id: "4",
      #   room_num: "15",
      #   start_date: "2009-4-4",
      #   end_date: "2009-4-10",
      #   })

    res_1 = booking_system.create_reservation({
      id: "1",
      room_num: "20",
      start_date: "2010-8-1",
      end_date: "2010-8-10",
      })
    res_2 = booking_system.create_reservation({
      id: "2",
      room_num: "19",
      start_date: "2010-8-15",
      end_date: "2010-8-18",
      })
    res_3 = booking_system.create_reservation({
      id: "4",
      room_num: "15",
      start_date: "2010-8-4",
      end_date: "2010-8-20",
      })

    @matching_res = booking_system.list_reservations_for_date("2010-8-5")
    puts @matching_res

    end

    it "should return an array of Reservation objects" do
      expect(@matching_res).must_be_kind_of Array
      expect(@matching_res[0]).must_be_kind_of Hotel::Reservation
    end

    it "accurately loads Reservation objects for specified date" do
      puts @matching_res
      expect(@matching_res.length).must_equal 2
      expect(@matching_res[0].id).must_equal 1
      expect(@matching_res[1].id).must_equal 4
    end

    it "returns nil if no Reservations are found for specified date" do
      @matching_res = booking_system.list_reservations_for_date("2010-8-30")
      expect(@matching_res).must_equal nil
    end
  end


end
