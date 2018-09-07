require_relative 'spec_helper'

# TODO: fix the order of these methods!
# QUESTION: wave 2 -- Your code should raise an exception when asked to reserve a room that is not available -- huhhh? i thought they book with a date range!
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

  describe "#create_date_range" do
    let(:start_date) {Date.parse("07-01-2010")}
    let(:end_date) {Date.parse("07-04-2010")}
    let(:date_range) {booking_system.create_date_range(start_date, end_date)}

    it "returns an array of Date objects" do
      expect(date_range).must_be_kind_of Array
      date_range.each do |date|
        date.must_be_kind_of Date
      end
    end

    it "accurately returns first Date value" do
      expect(date_range[0]).must_equal start_date
    end

    it "accurately returns last Date value" do
      expect(date_range[-1]).must_equal end_date-1
    end
  end

  describe "#generate_res_id" do
    let(:first_res) {Reservation.new("08-01-1996", "08-03-1996")}
    let(:second_res) {Reservation.new("09-09-1996", "08-13-1996")}
    let(:third_res) {Reservation.new("10-01-1996", "10-10-1996")}

    it "creates the first reservation ID if it's the first reservation in reservations list" do
      booking_system.reservations << first_res

      expect(reservations.generate_res_id[0].id).must_equal 1
    end

    it "can generate accurate IDs when new reservations are added to reservations list" do
      booking_system.reservations << first_res
      booking_system.reservations << second_res

      expect(reservations.generate_res_id[0].id).must_equal 1
      expect(reservations.generate_res_id[1].id).must_equal 2

      booking_system.reservations << third_res

      expect(reservations.generate_res_id[-1].id).must_equal 3
    end





  end
#
#   describe "#list_all_rooms" do
#     let(:all_rooms_str) {booking_system.list_all_rooms()}
#
#     it "lists all rooms as a string" do
#       beginning_text = "Here is a list of all rooms:"
#       room_2 = "Room 2"
#
#       expect(all_rooms_str).must_be_kind_of String
#       expect(all_rooms_str).must_include beginning_text
#       expect(all_rooms_str).must_include room_2
#     end
#   end
#
#   describe "#find_room" do
#     let(:room_num) {4}
#     let(:room_obj) {booking_system.find_room(room_num)}
#
#     it "finds room object by room number" do
#       # num = 4
#       # room_obj = booking_system.find_room(num)
#
#       expect(room_obj).must_be_kind_of Hotel::Room
#       expect(room_obj.num).must_equal room_num
#     end
#   end
#

#
#   # TODO
#   describe "#overlap?" do
#   end
#
# # TODO: add create reservation method + 2nd input as room_num??
#   describe "#create_reservation" do
#     # TODO: A reservation is allowed start on the same day that another reservation for the same room ends
#     # TODO test that it's added to Room
#     # TODO test that it's added to reservations
#     # let(:room_num) {4}
#     # let(:room_obj) {booking_system.find_room(room_num)}
#     let(:reservation_hash) {{
#       id: "5",
#       room_num: "10",
#       start_date: "2010-8-6",
#       end_date: "2010-8-10",
#       }}
#     let(:new_reservation) {booking_system.create_reservation(reservation_hash)}
#
#     it "creates a new reservation successfully" do
#       expect(new_reservation).must_be_kind_of Hotel::Reservation
#     end
#
#     it "loads reservation details properly" do
#       # QUESTION: should i test values or types? in rideshare, seems like mostly type was tested....
#       expect(new_reservation.id).must_equal 5
#       expect(new_reservation.room.num).must_equal 10
#       expect(new_reservation.start_date).must_be_kind_of Date
#       expect(new_reservation.end_date).must_be_kind_of Date
#       expect(new_reservation.daily_rate).must_equal 200
#
#     end
#   end
#
#   # describe "#add_reservation" do
#   #   updated_reservations = booking_system.add_reservation(new_reservation)
#   # end
#
#   # describe "#load_reservations" do
#   # end
#
#   describe "#list_reservations_for_date" do
#     let(:res_1) {booking_system.create_reservation({
#       id: "1",
#       room_num: "20",
#       start_date: "2010-8-1",
#       end_date: "2010-8-10"
#       })}
#
#     let(:res_2) {booking_system.create_reservation({
#       id: "2",
#       room_num: "19",
#       start_date: "2010-8-15",
#       end_date: "2010-8-18"
#       })}
#
#     let(:res_3) {booking_system.create_reservation({
#       id: "4",
#       room_num: "15",
#       start_date: "2010-8-4",
#       end_date: "2010-8-20"
#       })}
#
#     let(:matching_res) {booking_system.list_reservations_for_date("2010-8-5")}
#     # puts @matching_res}
#     # res_1 = booking_system.create_reservation({
#     #   id: "1",
#     #   room_num: "20",
#     #   start_date: "2010-8-1",
#     #   end_date: "2010-8-10",
#     #   })
#     # res_2 = booking_system.create_reservation({
#     #   id: "2",
#     #   room_num: "19",
#     #   start_date: "2010-8-15",
#     #   end_date: "2010-8-18",
#     #   })
#     # res_3 = booking_system.create_reservation({
#     #   id: "4",
#     #   room_num: "15",
#     #   start_date: "2010-8-4",
#     #   end_date: "2010-8-20",
#     #   })
#
#     # @matching_res = booking_system.list_reservations_for_date("2010-8-5")
#     # puts @matching_res
#     # end
#
#     it "should return an array of Reservation objects" do
#       expect(matching_res).must_be_kind_of Array
#       expect(matching_res[0]).must_be_kind_of Hotel::Reservation
#     end
#
#     it "accurately loads Reservation objects for specified date" do
#       expect(matching_res.length).must_equal 2
#       expect(matching_res[0].id).must_equal 1
#       expect(matching_res[1].id).must_equal 4
#     end
#
#     it "returns nil if no Reservations are found for specified date" do
#       matching_res = booking_system.list_reservations_for_date("2010-8-30")
#       expect(matching_res).must_equal nil
#     end
#   end
#
#   describe "#list_avail_rooms_for_date" do
#     let(:start_date) {"2010-8-15"}
#     let(:end_date) {"2010-8-16"}
#
#     it "returns an array of room numbers" do
#       expect(booking_system.available_rooms_by_date(start_date, end_date)).must_be_kind_of Array
#
#       expect(booking_system.available_rooms_by_date(start_date, end_date)[0]).must_be_kind_of Integer
#
#     end
#   end
#
#   #TODO
#   describe "#list_avail_rooms_for_range" do
#   end
#
#   # TODO
#   describe "#create_res_id" do
#   end
#

end
