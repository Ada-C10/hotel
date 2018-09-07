require 'csv'
require 'pry'

class Admin
  attr_reader :reservations, :find_reservation, :rooms, :vacant_rooms, :booked_rooms
  def initialize
    @reservations = load_reservations('spec/test_data/test_reservation.csv')
    @rooms = create_rooms(20)
    sort_reservations
    @vacant_rooms = []
    @booked_rooms = []
  end

  def create_rooms(number)
    rooms = []
    number.times do |num|
      input_data = {}
      room_number = num + 1
      input_data[:number] = room_number
      input_data[:status] = "available"
      rooms << Room.new(input_data)
    end
    return rooms
  end

  def load_reservations(filename)
    reservations = []

    CSV.read(filename, headers: true).each do |line|
      data = line.to_h
      input_data = {}
      input_data[:id] = data["id"].to_i
      input_data[:start_time] = Time.parse(data["start_time"])
      input_data[:end_time] = Time.parse(data["end_time"])
      reservations << Reservation.new(input_data)
    end

    return reservations
  end

  #As an administrator, I can reserve a room for a given date range
  # continue here: must be updated to use vacant_rooms
  def reserve_room(start_date, end_date)
    start_date = Time.parse(start_date)
    end_date = Time.parse(end_date)
    range = (start_date..end_date)
    @vacant_rooms = view_vacant_rooms(range) if @vacant_rooms == []
    #returns range
    #room = @vacant_rooms.first.add_reservation(range)
    vacant_rooms.first.add_reservation(range)
    room = @vacant_rooms.first
    @booked_rooms << room
  end

  # As an administrator, I can access the list of all of the rooms in the hotel
  def view_all_rooms
    return @rooms
  end

  #As an administrator, I can access the list of reservations for a specific date
  def find_reservations(date)
    date = Time.parse(date)
    reservations = @reservations.select do |instance|
      start_date = instance.start_time
      end_date = instance.end_time
      if date_in_range(start_date, end_date, date)
        instance
      end
    end
    return reservations
  end

  #As an administrator, I can get the total cost for a given reservation
  def find_cost(reservation_id)
    reservation = @reservations.select { |instance| instance.id == reservation_id }[0]
    cost = reservation.cost
    return cost
  end

  #As an administrator, I can view a list of rooms that are not reserved for a given date range
  ## broke because it I used this in reserve_room
  def view_vacant_rooms(target_range)
    @rooms.each do |room|
      ranges = room.ranges
      found = range_search(ranges, target_range)
      if found
        booked_rooms << room
      else
        vacant_rooms << room
      end
    end
    return vacant_rooms
  end

  private
  def sort_reservations
    @reservations.sort_by { |object| object.start_time }
  end

  def date_in_range(start_date, end_date, date)
    range = (start_date..end_date)
    range.include?(date)
  end

  def range_search(ranges, target)
    ranges.each do |range|
      if range == target
        return true
      end
    end
    return false
  end
end
