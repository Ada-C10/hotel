require 'pry'
require 'date'

class ReservationMaker

  attr_reader :start_date, :end_date

  @@reservations = []

  def initialize (start_date, end_date)
    @start_date = start_date
    @end_date = end_date

    #Makes sure dates entered are realistic.  A start date after the end date is not.
    if @end_date < @start_date
      raise ArgumentError.new ("The start date cannot be after the end date.")
    end
  end

  # This makes it so the @@reservations data is cumulative and keeps track of all reservations ever made with the program.
  def self.reservations
    @@reservations
  end

  # Dan added this part so that the above would work with the testing setup.
  def self.reset
    @@reservations = []
  end

  # lists all rooms in the hotel
  def rooms
    rooms = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    return rooms
  end

  # creates a list of all Booked Rooms (or rooms that are unavailable to be booked by the current customer) during the time frame requested.
  def booked_rooms
    booked_rooms = []
    unless @@reservations.nil?
      @@reservations.each do |reservation|
        if @start_date < reservation.start_date && @end_date <= reservation.start_date || @start_date >= reservation.end_date
          booked_rooms << reservation.room
          # binding.pry
        end
      end
    end
    # binding.pry
    return booked_rooms
  end

  # Creates a list of Available Rooms for the current customer by removing the booked rooms from the main rooms list and returning a list of rooms available to be booked by the customer.
  def available_rooms
    available_rooms = []
    booked_room_list = booked_rooms

    unless booked_room_list.nil?
      rooms.each do |room|
        if booked_room_list.include?(room)
          #seems clunky here, but .exclude? didn't work
        else
          available_rooms << room
        end

      end
    end
    return available_rooms
  end

  # If there are rooms available, a reservation will be created using a randomly chosen room number from the Available Rooms list.
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
