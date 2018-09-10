require "date"

require_relative 'calendar'
require_relative 'reservation'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations

    def initialize()
      @rooms = list_all_rooms() #<-- array of all room numbeers
      @reservations = []
    end

    def list_all_rooms()
      return (1..20).to_a
    end

    def construct_cal_checker(check_in:, check_out:)
      return Calendar.new(check_in: check_in, check_out: check_out)
    end

    def generate_res_id()
      if @reservations.empty?
        return 1
      else
        return @reservations.max_by { |reservation| reservation.id}.id + 1
      end
    end

    def list_res_for_date(check_date)
      matching_res = @reservations.select { |reservation| reservation.has_date?(check_date) } #==false

      return matching_res.empty? ? nil : matching_res

    end

    def list_avail_rooms_for_range(check_in:, check_out:)
      date_range = construct_cal_checker(check_in: check_in, check_out: check_out)

      avail_rooms = @reservations.select { |reservation| !reservation.overlap?(date_range) }.map { |reservation| reservation.room_num }

      return avail_rooms.empty? ? nil : avail_rooms
    end

#     # TODO: maybe use date range instead of start/end?
#     def create_reservation(start_date, end_date)
#       id = create_res_id()
#       rooms = list_avail_rooms_for_range(start_date, end_date)
#
#       # QUESTION: AM I DOING THIS RIGHT?
#       unless rooms != nil
#         raise StandardError, "No rooms are available for the given date range: #{start_date} - #{end_date}."
#       end
#
#       reservation_hash = {
#         id: id,
#         room: rooms[0],
#         check_in: start_date,
#         check_out: end_date,
#       }
#
#       new_reservation = Reservation.new(reservation_hash)
#       #NOTE: add room.change_status??? should this part go in Res???
#       # or should this be split up????
#       room.add_reservation(new_reservation)
#       @reservations << new_reservation
#
#       return new_reservation
#     end
#
#     # QUESTION: NOT NEEDED-- JUST IN RESERVATION?
#     # def add_reservation(new_reservation)
#     #   @reservations << create_reservation(new_reservation)
#     # end
#
#     # QUESTION: add loading class or hold off? should be blank list at top?
#     # def load_reservations(input)
#     #   new_reservation = create_reservation()
#     #   add_reservation(new_reservation)
#     #   return @reservations
#     # end
#
#
# # QUESTION: should i be accessing this
# # QUESTION: add a pretty to_s for listing reserved dates?
#     def list_reservations_for_date(check_date)
#       date = Date.parse(check_date)
#       #TODO error handling for date as Date object??
#       #TODO what if no dates match? should return nil?
#       # QUESTION: maybe add one to display by id?
#       # QUESTION: should room own this???
#       matching_res = @reservations.select { |reservation| reservation.dates_reserved.include? date }
#
#       # TODO: combine enumerable with ternary???? --> do in one line???
#       return matching_res.empty? ? nil : matching_res
#     end
#
#
# # QUESTION: should this method be here or in Reservation?
# # QUESTION: test nil return if nothing found
#     def find_room(room_num)
#       return @rooms.find {|room| room.num == room_num.to_i}
#     end
#

#

#

  end
end


# booking = Hotel::BookingSystem.new()
#
# res_3 = Hotel::Reservation.new(
#   id: "4",
#   room_num: "15",
#   check_in: "2010-8-4",
#   check_out: "2010-8-20",
#   )
# res_2 = Hotel::Reservation.new(id: "1",
#   room_num: "20",
#   check_in: "2010-8-1",
#   check_out: "2010-8-10",
#   )
#
# booking.reservations.push(res_2, res_3)
#
# p booking.list_avail_rooms_for_range(check_in: "2010-10-15", check_out: "2010-10-26")
