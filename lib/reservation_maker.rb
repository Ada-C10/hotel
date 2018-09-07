require 'pry'
require 'date'

class ReservationMaker

  attr_reader :start_date, :end_date

  @@reservations = []

  def initialize (start_date, end_date)
    @start_date = start_date
    @end_date = end_date

    if @end_date < @start_date
      raise ArgumentError.new ("The start date cannot be after the end date.")
    end
  end

  def self.reservations
    @@reservations
  end

  def self.reset
    @@reservations = []
  end

  def rooms
    rooms = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    return rooms
  end

  def booked_rooms
    booked_rooms = []
    unless @@reservations.nil?
      @@reservations.each do |reservation|
        if reservation.start_date >= @start_date && reservation.end_date < @end_date || reservation.end_date - 1 >= @start_date
          booked_rooms << reservation.room
        end
      end
    end
    # binding.pry
    return booked_rooms
  end

  def available_rooms
    available_rooms = []
    booked_room_list = booked_rooms

    unless booked_room_list.nil?
      rooms.each do |room|
        if booked_room_list.include?(room)
          
        else
          available_rooms << room
        end
      end
    end
    return available_rooms
  end

  def create_reservation
    room = available_rooms.sample
    if room.nil?
      raise StandardError.new ("There are no rooms available for that time period.")
    end
    new_reservation = Reservation.new(@start_date, @end_date, room)
    @@reservations << new_reservation
    return new_reservation
    # binding.pry
  end
end
