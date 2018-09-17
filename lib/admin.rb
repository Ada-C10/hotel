require_relative 'reservation.rb'
require_relative 'room.rb'
require 'Date'
require 'pry'


ROOMS_PRIOR_TO_BOOKING =  [{1=>[]},{2=>[]},{3=>[]},{4=>[]},{5=>[]},{6=>[]},{7=>[]},{8=>[]},
{9=>[]},{10=>[]},{11=>[]},{12=>[]},{13=>[]},{14=>[]},{15=>[]},{16=>[]},{17=>[]},
{18=>[]},{19=>[]},{20=>[]}]

class Admin
  def initialize
    @rooms = ROOMS_PRIOR_TO_BOOKING
    @blocked_rooms = []
    @blocked_start_date = nil
    @blocked_end_date = nil
  end

  attr_accessor :blocked_start_date, :blocked_end_date

  def block_rooms(number_blocked, check_in_date, check_out_date)
    @blocked_start_date = check_in_date
    @blocked_end_date = check_out_date
    number_blocked.times do |i|
      rooms_sent = @rooms
      entry = Room.new((20 - i), @blocked_start_date, @blocked_end_date, rooms_sent)
      entry.block_room_in_room
      @rooms = Room.rooms
      @blocked_rooms << 20 - i
    end
    return @blocked_rooms
  end

  def book_blocked_room
    if @blocked_rooms != []
      room = @blocked_rooms[0]
      special_reservation = Reservation.new(room, @blocked_start_date, @blocked_end_date)
      special_reservation.cost_special
      rooms_sent = @rooms
      entry = Room.new(room, @blocked_start_date, @blocked_end_date, rooms_sent)
      entry.book_blocked_room_in_room
      @rooms = Room.rooms
      @blocked_rooms.delete(@blocked_rooms[0])
    end
    return @blocked_rooms
  end

  def view_all_rooms
    return @rooms
  end

  def reserve(room_number, check_in_date, check_out_date)
    if Date.parse(check_in_date) > Date.parse(check_out_date) ||
      Date.parse(check_in_date).class != Date ||
      Date.parse(check_out_date).class != Date
       raise StandardError, "Dates are invalid!"
    end

    Reservation.new(room_number, check_in_date, check_out_date)
    rooms_sent = @rooms
    entry = Room.new(room_number, check_in_date, check_out_date, rooms_sent)
    entry.book_room
    @rooms = Room.rooms
  end

  def rooms_reserved_by_date(date)
    reserved = []
    @rooms.each do |hash|
      hash.each do |key, value|
        value.each do |date_range|
          if Date.parse(date) > Date.parse(date_range[0]) &&
            Date.parse(date) < Date.parse(date_range[1])
            reserved << key
            return reserved
          end
        end
      end
    end
  end

  def print_total_cost_per_reservation(reservation_id = nil)
    if reservation_id != nil
      Reservation.reservations.each do |reservation|
        if reservation[3] == reservation_id
          return reservation[4]
        end
      end
    else
      last = Reservation.reservations[-1]
      return last[4]
    end
  end

  def check_availability (check_in_date, check_out_date = nil)
    available_rooms = []
    if check_out_date == nil
      check_out_date = check_in_date
    end
    @rooms.each do |hash|
      hash.each do |key,value|
        if value != []
          value.each do |date_range|
            if Date.parse(check_in_date) < Date.parse(date_range[0]) && Date.parse(check_out_date) <= Date.parse(date_range[0]) ||
              Date.parse(check_in_date) >= Date.parse(date_range[1]) && Date.parse(check_out_date) > Date.parse(date_range[1])
              available_rooms << key
            end
          end
        else
          available_rooms << key
        end
      end
    end
    return available_rooms
  end

end
