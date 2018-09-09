require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class BookingSystem
    attr_reader :room, :reservations


    # TODO: Change class name to booking system?

    def initialize
      # All my rooms
      @room = (1..20).to_a
      # List of reservations. Organized by room?
      @reservations = []

    end

    def list_rooms
      return @room
    end

    def make_reservation(date_range)
      #think...what if there's no available rooms, raise an exception

      room = find_available_rooms(date_range)[0]

      reservation = Reservation.new(date_range, room)

      @reservations << reservation
    end

    # If we need reservations for a particular room:
    # @reservations.select { |res| res.room_number == room_number }

    def list_reservations(date_range)
      return @reservations.select { |res| res.date_range == date_range }
    end

    def find_available_rooms(date_range)

      # TODO: refactor?
      room_1 = [1]
      return room_1 if @reservations.empty?


      # puts 'BEFORE RESERVATIONS LOOP'
      unavailable_rooms = []
      # puts "unavailable rooms:"
      # puts "#{unavailable_rooms}"
      # puts "available rooms"
      # puts "#{available_rooms}"
      # puts
      # puts

      @reservations.each do |res|
        if date_range.dates_overlap?(res.date_range)
          # binding.pry
          unavailable_rooms << res.room_number
        else

        end
      end

      # puts "AFTER RESERVATIONS LOOP"
      # puts "unavailable rooms:"
      # puts "#{unavailable_rooms}"
      # puts "available rooms"
      # puts "#{available_rooms}"
      # puts
      # puts


      available_rooms = @room.reject { |r| unavailable_rooms.include?(r) }


      # binding.pry

      # @room.each do |r|
      #   unavailable_rooms.each do |unavailable_room|
      #     if r != unavailable_room
      #       available_rooms << r
      #
      #     end
      #   end
      # end

      # puts "AFTER ROOM LOOP"
      # puts "unavailable rooms:"
      # puts "#{unavailable_rooms}"
      # puts "available rooms"
      # puts "#{available_rooms}"
      # puts
      # puts
      # puts "ROOM ARRAY"
      # puts "#{@room}"
      # puts "*" * 50
      return available_rooms


    end

    def list_available_rooms(date_range)
      return @room if @reservations.empty?

      return find_available_rooms(date_range)
    # def self.available_rooms
    #   return @@available_rooms
    # end
    end


  end
end

date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
date_range_2 = Hotel::DateRange.new('2018-09-15', '2018-09-20')
date_range_3 = Hotel::DateRange.new('2018-08-29', '2018-09-02')
date_range_4 = Hotel::DateRange.new('2018-10-01', '2018-10-20')
reservation = Hotel::BookingSystem.new()
reservation_1 = Hotel::BookingSystem.new()

5.times do
  reservation.make_reservation(date_range_1)
end

2.times do
  reservation.make_reservation(date_range_2)
end

3.times do
  reservation.make_reservation(date_range_3)
end

puts "#{reservation.list_available_rooms(date_range_1)}"
puts "#{reservation_1.list_available_rooms(date_range_1)}"
puts "#{reservation.list_available_rooms(date_range_4)}"


#
# puts reservation.list_reservations(date_range_1).first.room_number
# puts reservation.list_reservations(date_range_1).last.room_number

# reservation.list_reservations(date_range_1).each_with_index do |res, i|
#   puts "#{i}. Room ##{res.room_number}, Start Date: #{res.date_range.start_date}"
# end
# #
#
# reservation.list_reservations(date_range_2).each_with_index do |res, i|
#   puts "#{i}. Room ##{res.room_number}, Start Date: #{res.date_range.start_date}"
# end
#
# reservation.list_reservations(date_range_3).each_with_index do |res, i|
#   puts "#{i}. Room ##{res.room_number}, Start Date: #{res.date_range.start_date}"
# end
# array = reservation.reservations
# array.each_with_index do |res, i|
#   puts "#{i}. Room ##{res.room_number}, Start Date: #{res.date_range.start_date}"
# end
#
# puts "#{Hotel::BookingSystem.available_rooms}"
