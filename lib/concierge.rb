require 'awesome_print'
require 'date'
require 'csv'
require_relative 'lodging'
require_relative 'room'
#concierge can ACCESS list of all rooms in hotel = yes
#concierge can RESERVE reservation for date range = yes
#concierge can RESERVE new res. on last day of prev. one
#concierge can ACCESS list of reservations on date = yes
#concierge can ACCESS receipt for completed stay = yes
#receipt does NOT INCLUDE last day = yes
#can view rooms NOT RESERVED on date
#datevar.strftime("%b %d, %Y") - date output

module Lodging

  class Concierge

    attr_accessor :rooms_info

    def initialize(room_count)
      Lodging.create_rooms(room_count) #creating rooms upon initialization

      rooms = CSV.read('data/all_hotel_rooms.csv', headers: true, header_converters: :symbol).map do |room|
        room.to_h
      end
      @rooms_info = rooms
    end

    def all_rooms
      return @rooms_info
    end

    def new_reservation(check_in, check_out) #makes new reservation based on two dates

      raise ArgumentError if Date.parse(check_out) < Date.parse(check_in) #checkout cannot be earlier than check in

      book_this = Lodging.room_status(@rooms_info) #returns one availalbe room

      reserved_dates = Lodging.create_date_range(check_in, check_out) #parses range for date, into array

      update_room = @rooms_info.find do |room|
        room[:room_number] == book_this[:room_number]
      end #finds room to be reserved

       update_room[:status] = "unavailable" #changes status of said room in the array of hashes as 'unavailable'
       update_room[:reserved_dates] = reserved_dates

    end
    #
    def reserved_rooms(date) #see list of reserved rooms by date

      raise ArgumentError if !Date.parse(date).instance_of? Date

      search_date = Date.parse(date)

      reserved_rooms = @rooms_info.find_all do |room|
        room if room[:reserved_dates]
      end

      reserved_room_list = reserved_rooms.select do |room|
        room if room[:reserved_dates].include? search_date
      end

      return reserved_room_list


    end

    def receipt(room_number) #date step method to determine day count
      check_out_room = @rooms_info.find do |room|
        room_number.to_s == room[:room_number]
      end

      cost = check_out_room[:cost].to_f
      total_days = check_out_room[:reserved_dates].length - 1

      return (cost * total_days).round(2)

    end


  end
end
