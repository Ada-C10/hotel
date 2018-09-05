require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/booking_system'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "BookingSystem class" do
  let(:booking_system) {Hotel::BookingSystem.new()}

  describe "#initialize" do
    it "can create a new instance of BookingSystem" do
      expect(booking_system).must_be_kind_of Hotel::BookingSystem
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
    let(:room_num) {num: 4}
    let(:room_obj) {booking_system.find_room(room_obj)}

    it "finds room object by room number"
      # num = 4
      # room_obj = booking_system.find_room(num)

      expect(room_obj).must_be_kind_of Hotel::Room
      expect(room_obj.num).must_equal num
    end
  end

  describe "#create_reservation" do
    let(:reservation_hash) {{
      id: "5",
      room: room_obj,
      start_date: ("2010, 8, 6")
      end_date: ("2010, 8, 10")
      }}
    let(:new_reservation) {Reservation.new(reservation_hash)}

    it "creates a new reservation successfully" do
      expect(new_reservation).must_be_kind_of Hotel::Reservation
    end

    it "loaded reservation details properly" do
      # QUESTION: should i test values or types? in rideshare, seems like mostly type was tested....
      expect(new_reservation.id).must_equal 5
      expect(new_reservation.room.num).must_equal 4
      expect(new_reservation.start_date).must_be_kind_of Date
      expect(new_reservation.end_date).must_be_kind_of Date
      expect(new_reservation.cost).must_equal 200

    end
  end

  # describe "#add_reservation" do
  #   updated_reservations = booking_system.add_reservation(new_reservation)
  # end

  # describe "#load_reservations" do
  # end

# # TODO - i think?
#   describe "#list_reservations_by_date" do
#   end


end
