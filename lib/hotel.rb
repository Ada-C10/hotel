require 'pry'
require_relative 'room'
require_relative 'reservation'

module Hotel
  class Hotel

    attr_reader :rooms, :reservations, :reservation_blocks, :avail_rooms, :blocked_blocks

    def initialize
      @rooms = []
      (1..20).each do |num|
        room = Room.new(num)
        @rooms << room
      end
      @reservations = []
      @blocked_blocks = []

    end



    #returns an array of numbers from a collection of room instances (room_num)
    def get_all_numbers
      room_nums = []
      @rooms.each do |room|
        room_nums << room.room_num
      end
      return room_nums
    end

    #assings room from the available room's array
    def get_available_room(start_date, end_date)
      avail_rooms = nonreserved_rooms_fordates(start_date, end_date)
      return avail_rooms.first
    end

    #assigns a reservation given a vaild date, and also calls the get_available_room method which will then return a room number. @reservation is storing all the reservations
    def assigns_a_reservation(start_date, end_date)

      room_num = get_available_room(start_date, end_date)

      if room_num == nil
        raise ArgumentError.new("There are no more rooms available at this time for this date range #{start_date} - #{end_date}, you are not allowed to reserve a room that is not available")
      end

      reservation = Reservation.new(start_date, end_date, room_num)
      @reservations << reservation
      reservation.add_reservation(reservation)
      return reservation
    end


    #returns matched reservations for a specific date
    # def reservations_for_date(date)
    #   if contains?(date)
    #     return
    #   end


      # matches = []
      # @reservations.each do |reservation|
      #   if reservation.start_date <= date && reservation.end_date > date
      #     matches << reservation
      #   end
      #   return matches
      # end
    # end



    def reserved_rooms_for_dates(start_date, end_date)
      matched_date_range = []

      @reservations.each do |reservation|
        if reservation.start_date.between?(start_date, end_date)
          matched_date_range << reservation.room_num
        elsif reservation.end_date.between?(start_date, end_date)
          matched_date_range << reservation.room_num
        elsif start_date < reservation.start_date && end_date > reservation.end_date
          matched_date_range << reservation.room_num
        end
      end

      @blocked_blocks.each do |block|
        if block.start_date.between?(start_date, end_date)
          matched_date_range += block.blocked_rooms
        elsif block.start_date.between?(start_date, end_date)
          matched_date_range += block.blocked.rooms
        elsif start_date < block.start_date && end_date > block.end_date
          matched_date_range += block.blocked_rooms
        end
      end
      return matched_date_range

    end


    def nonreserved_rooms_fordates(start_date, end_date)
      matched_rooms_range = reserved_rooms_for_dates(start_date, end_date)
      all_room_numbers = get_all_numbers
      avail_rooms = all_room_numbers - matched_rooms_range
      return avail_rooms
    end


    def block_rooms(start_date, end_date, num_of_rooms, name)

      if num_of_rooms > 5
        raise ArgumentError.new("can't be more than 5")
      end

      avail_rooms = nonreserved_rooms_fordates(start_date, end_date)

      if num_of_rooms > avail_rooms.length
        raise ArgumentError.new("This many block rooms are not available #{num_of_rooms} the number that is actucally available is #{avail_rooms}")
      end

      blocked_rooms = avail_rooms[0..num_of_rooms]
      block = Block.new(start_date, end_date, blocked_rooms, name)
      @blocked_blocks << block
      return @blocked_blocks

    end

    def reserve_block_room(number_of_rooms, name)
      reservation = 0
      single_block = @blocked_blocks.find { |block| block.name == name }

      rooms = single_block.get_avail_room(number_of_rooms)

      rooms.each do |room|
        reservation = Reservation.new(single_block.start_date, single_block.end_date, room)
        @reservations << reservation
      end
      return @reservations
    end


  end
end






























#___________________________________________________________________________

# def initialize (start_time, end_time, room)
#   @start_time = start_time
#   @end_time = end_time
#   @room = room
#
#   reserve_room
#
#   @hotel_instances = list_hotel
#   @reservation_list = []
# end
#
# def list_hotel
#   hotel_rooms_array = []
#   hotel_rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
#   hotel_rooms.each do |room_num|
#     instance = Room.new(room_num)
#     hotel_rooms_array << instance
#   end
#   return hotel_rooms_array
# end
#
# #list of reservations once they have been made
# def list_reservations
#
# end

# method to actually reserve a room
# def reserve_room
#   one_reservation_request = Reservation.new(@start_time, @end_time, @room).Room.new(@room).availability(@start_time, @end_time)
#   if one_reservation_request == ":available"
#     @reservation_list << one_reservation_request
#   else
#     return "sorry the room is not available for this time"
#   end
#   return @reservation_list
#
# end
# end
