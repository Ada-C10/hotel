require 'awesome_print'
require 'date'
require 'csv'
require 'pry'

require_relative 'room'
#concierge can ACCESS list of all rooms in hotel = yes
#concierge can RESERVE reservation for date range = yes
#concierge can RESERVE new res. on last day of prev. one
#concierge can ACCESS list of reservations on date = yes
#concierge can ACCESS receipt for completed stay = yes
#receipt does NOT INCLUDE last day = yes
#can view rooms NOT RESERVED on date = yes
#can block reservation = yes
#datevar.strftime("%b %d, %Y") - date output

module Lodging

  class Concierge

    attr_accessor :rooms_info

    def initialize(room_count)
      Concierge.create_rooms(room_count) #creating rooms upon initialization

      rooms = CSV.read('data/all_hotel_rooms.csv', headers: true, header_converters: :symbol).map do |room| #converting string headers to symbols for hash
        room[:reserved_dates] = [] #converting string '[]' to empty array []
        room.to_h
      end
      @rooms_info = rooms
    end

    def all_rooms
      return @rooms_info
    end

    def new_reservation(check_in, check_out) #makes new reservation based on two dates

      raise ArgumentError if Date.parse(check_out) < Date.parse(check_in) #checkout cannot be earlier than check in

      book_this = Concierge.available_room(@rooms_info, check_in) #returns one available room

      reserved_dates = Concierge.create_date_range(check_in, check_out) #parses range for date, into array

      update_room = @rooms_info.find do |room|
        room[:room_number] == book_this[:room_number]
      end #finds room to be reserved

       update_room[:status] = "unavailable" #changes status of said room in the array of hashes as 'unavailable'
       update_room[:reserved_dates] += reserved_dates #all reserved dates are added under previous dates
    end

    def new_block(check_in, check_out, block = 1, discount = 0.15) #makes new reservation based on two dates

      raise ArgumentError if Date.parse(check_out) < Date.parse(check_in) #checkout cannot be earlier than check in

      reserved_dates = Concierge.create_date_range(check_in, check_out) #parses range for date, into array

      block.times do
        hold_this = Concierge.available_room(@rooms_info, check_in) #returns one available room

        update_room = @rooms_info.find do |room|
          room[:room_number] == hold_this[:room_number]
        end #finds room to be reserved

        new_cost = (update_room[:cost].to_f) - (update_room[:cost].to_f * discount)

        update_room[:cost] = new_cost.round(2).to_s
        update_room[:status] = "hold" #changes status of said room in the array of hashes as 'unavailable'
        update_room[:reserved_dates] += reserved_dates #all reserved dates are added under previous dates
        ap update_room
      end
    end

    def block_reserve(check_in, check_out)
      block_dates = Concierge.create_date_range(check_in, check_out) #parses range for date, into array
      held_room = @rooms_info.find do |room|
        room[:status] == 'hold' && room[:reserved_dates] == block_dates
      end #finds room to be reserved

      raise ArgumentError if held_room == nil

      held_room[:status] = 'unavailable' #changes status to unavailable aka reserved
    end

    def reserved_rooms(date) #see list of reserved rooms by date

      raise ArgumentError if !Date.parse(date).instance_of? Date

      search_date = Date.parse(date)

      reserved_rooms = @rooms_info.find_all do |room|
        room if room[:reserved_dates]
      end

      reserved_rooms.select! do |room|
        room[:reserved_dates].include? search_date
      end

      return reserved_rooms

    end

    def view_avail(date)

      raise ArgumentError if !Date.parse(date).instance_of? Date

      search_date = Date.parse(date)

      avail_rooms = @rooms_info.find_all do |room|
        room if room[:status] == 'available'
      end

      avail_rooms = @rooms_info.reject! do |room|
        room[:reserved_dates].include? search_date
      end

      return avail_rooms
    end

    def receipt(room_number) #date step method to determine day count
      check_out_room = @rooms_info.find do |room|
        room_number.to_s == room[:room_number]
      end

      cost = check_out_room[:cost].to_f
      total_days = check_out_room[:reserved_dates].length - 1

      return Concierge.total_owed(total_days, cost)

    end

    #creates multiple rooms at once, and assigns room number
    def self.create_rooms(room_count, cost = 200) #creates new rooms, assigns room no.
      raise ArgumentError if !room_count.is_a? Integer
      i = 1
      room_count.times do
        Room.new(i, cost)
        i += 1
      end
    end

  def self.available_room(input, check_in) #check room_status
    avail = input.find do |room|
      room[:reserved_dates].last == Date.parse(check_in) || room[:status] == "available" #returns first instance it finds of available room
    end

    raise ArgumentError if avail == false

    return avail
  end

  def self.total_owed(multiplier, price) #date step method to determine day count
      total = multiplier.to_f * price.to_f
      return total.round(2)
  end

  def self.create_date_range(date1, date2)
    return (Date.parse(date1)..Date.parse(date2)).to_a
  end


  end

  end
end
