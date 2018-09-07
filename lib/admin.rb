require 'csv'
require 'pry'

#REFACTOR_IDEAS:
# create helper method that creates instance of time, and a range

class Admin
  attr_reader :reservations, :find_reservation, :rooms, :vacant_rooms, :booked_rooms
  def initialize
    @reservations = load_reservations('spec/test_data/test_reservation.csv')
    @rooms = create_rooms(20)
    sort_reservations
    #@vacant_rooms = []
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
  # uses view_vacant_rooms create range with one day less
  def reserve_room(start_date, end_date)
    start_date = Time.parse(start_date)
    end_date = Time.parse(end_date)
    range = (start_date..end_date)
    vacant_rooms = view_vacant_rooms(range)
    vacant_rooms.first.add_reservation(range)
    room = vacant_rooms.first
    @booked_rooms << room
  end

  # As an administrator, I can access the list of all of the rooms in the hotel
  def view_all_rooms
    return @rooms
  end

  #As an administrator, I can access the list of reservations for a specific date
  # do I have to return a reservation that has specific date at the end?
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
  #input to be a reservation instance?
  def find_cost(reservation_id)
    reservation = @reservations.select { |instance| instance.id == reservation_id }[0]
    cost = reservation.cost
    return cost
  end

  #As an administrator, I can view a list of rooms that are not reserved for a given date range
  # it does this by seeing which rooms have the same range, but if not, it marks it as vacant
  # raise argument error if array is empty
  # must check if date for every single date is in the range
  def view_vacant_rooms(target_range)
    vacant_rooms = []
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

  #As an administrator, I can create a block of rooms
  def create_block_rooms(start_date, end_date, discounted_rate)
    start_date = Time.parse(start_date)
    end_date = Time.parse(end_date)
    range = (start_date..end_date)
    collection_rooms_options = view_vacant_rooms(range)
    # create blocks of five every time?
    # collections_rooms # it's an array
    # collections_rooms.each do |room|
    #   room
    # end



  end

  #last day not counted
  def create_hotel_range(start_date, end_date)
    start_date = Time.parse(start_date)
    end_date = Time.parse(end_date)
    end_date = end_date - 1
    range = (start_date .. end_date)
    return range
  end

  private
  #never used currently
  def sort_reservations
    @reservations.sort_by { |object| object.start_time }
  end

  # it returns true if last day is the target date. Okay for listing all reservations with a specific date
  def date_in_range(start_date, end_date, date)
    range = (start_date..end_date)
    range.include?(date)
  end

  # find range in an array of ranges, NOT USEFUL you need to check every day in the range not just that the ranges are not equal
  def range_search(ranges, target)
    ranges.each do |range|
      if range == target
        return true
      end
    end
    return false
  end
end
