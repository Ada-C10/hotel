require_relative 'reservation'
require_relative 'block_room'
require_relative 'date_range'

module Hotel
  class BookingSystem

    attr_reader :rooms, :reservations, :block_rooms

    def initialize
      @rooms = (1..20).to_a
      @reservations = []
      @block_rooms = []
    end

    def list_rooms
      return @rooms
    end

    def list_reservations(date_range)
      return @reservations.select { |res| res.date_range == date_range }
    end

    def list_available_rooms(date_range)
      return @rooms if @reservations.empty?
      return find_available_rooms(date_range)
    end

    def find_available_rooms(date_range)

      return @rooms if @reservations.empty?

      unavailable_rooms = @reservations.map { |res| res.room_number if date_range.dates_overlap?(res.date_range) }

      available_rooms = @rooms.reject { |r| unavailable_rooms.include?(r) }

      raise StandardError, "No rooms available for those dates." if available_rooms.empty?

      return available_rooms
    end

    def make_reservation(date_range)

      room = find_available_rooms(date_range).first
      reservation = Reservation.new(date_range, room)
      @reservations << reservation
      return reservation
    end

    def reserve_block_rooms(date_range)

      rooms = find_available_rooms(date_range)
      block_reservation = BlockRoom.new(date_range, rooms)
      @block_rooms << block_reservation
      return block_reservation
    end

    def find_block(date_range)
      raise StandardError, "No block rooms found for those dates" if @block_rooms.empty?

      return @block_rooms.select { |block| block.date_range == date_range }
    end

    def find_room_in_block(date_range)
      found_block = find_block(date_range)
      room_block_rooms = found_block.first.block_rooms

      available_rooms = find_available_rooms(date_range)

      room = available_rooms.select { |room| room if room_block_rooms.include? available_rooms }

      return room
    end

    def make_reservation_from_block(date_range)

      room = find_room_in_block(date_range).first
      reservation = Reservation.new(date_range, room)
      @reservations << reservation
      return reservation
    end


  end
end

date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
# date_range_2 = Hotel::DateRange.new('2018-09-15', '2018-09-20')
date_range_3 = Hotel::DateRange.new('2018-08-29', '2018-09-02')
# date_range_4 = Hotel::DateRange.new('2018-10-01', '2018-10-20')
reservation = Hotel::BookingSystem.new()

# reservation_1 = Hotel::BookingSystem.new()
#
10.times do
  reservation.make_reservation(date_range_1)
end

3.times do
  reservation.reserve_block_rooms(date_range_3)
end
#
#
# reservation.reserve_block_rooms(date_range_3)
#
# 3.times do
#   block_room.make_reservation_from_block(date_range_3)
# end
#
puts reservation.block_rooms.first.room_number
# puts reservation.find_available_rooms(date_range_1).class
# puts "#{reservation.list_available_rooms(date_range_1)}"
# puts "#{reservation_1.list_available_rooms(date_range_1)}"
# puts "#{reservation.list_available_rooms(date_range_4)}"


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
