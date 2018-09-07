require "date"

# require_relative 'room'
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
      # all_rooms = nums.map { |num| Hotel::Room.new(num: num)}
    end

    def create_date_range(start_date, end_date)
      # TODO: error handling should probably go to cal class (take from reservation plus tests -- 2x)
      return (start_date...end_date).to_a
    end

    def generate_res_id()
      if @reservations.empty?
        return 1
      else
        return @reservations.max_by { |reservation| reservation.id}.id + 1
      end
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
#     def overlap?(date_range_1, date_range_2)
#       return false if (date_range_1 & date_range_2).empty? else return true
#     end
#
#     def list_avail_rooms_for_date(check_date)
#       avail_rooms = @reservations.select { |reservation| !reservation.date_range.include?(check_date) } #==false
#         # check for no overlap in dates
#         # if (reservation.date_range & check_date_range).empty?
#
#       return avail_rooms.empty? ? nil : avail_rooms
#
#     end
#
#     def list_avail_rooms_for_range(start_date, end_date)
#       check_date_range = create_date_range(start_date, end_date)
#
#       avail_rooms = @reservations.select { |reservation| reservation.room if !overlap?(reservation.date_range, check_date_range)} #==false
#
#       return avail_rooms.empty? ? nil : avail_rooms
#         # check for no overlap in dates
#         # if (reservation.date_range & check_date_range).empty?
#
#     end
#

  end
end


# booking = Hotel::BookingSystem.new()
# #
# res_3 = booking.create_reservation({
#   id: "4",
#   room_num: "15",
#   start_date: "2010-8-4",
#   end_date: "2010-8-20",
#   })
# res_2 = booking.create_reservation({id: "1",
#   room_num: "20",
#   start_date: "2010-8-1",
#   end_date: "2010-8-10",
#   })
#
# p booking.available_rooms_by_date("2010-8-5")
