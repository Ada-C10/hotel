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
      input_data[:end_time] = Time.parse(data["end_time"]) # no need to subtract last day because reservation class only calculates cost
      reservations << Reservation.new(input_data)
    end

    return reservations
  end

  #As an administrator, I can reserve a room for a given date range
  # uses view_vacant_rooms create range with one day less
  def reserve_room(start_date, end_date)
    start_date = Time.parse(start_date)
    end_date = Time.parse(end_date)
    range = create_hotel_range(start_date, end_date)
    @rooms.first.add_range(range) # temporary - must be updated once view_vacant_rooms is fixed
    # vacant_rooms = view_vacant_rooms(range) # needs to be updated
    # vacant_rooms.first.add_range(range)
    # room = vacant_rooms.first
    # must create instance of reservation for this room using one more day
  end

  #As an administrator, I can view a list of rooms that are not reserved for a given date range
  # raise argument error if array is empty
  ## expects dates to be instances of time
  def view_vacant_rooms(start_date, end_date)
    vacant_rooms = @rooms
    target_range = create_hotel_range(start_date, end_date)
    vacant_rooms.each do |room|
        ranges = room.ranges
        ranges.each do |range|
            # nil means no intersection
            if intersection(target_range, range) != nil # there was a overlap
              vacant_rooms.delete(room)
              break
            end
        end
    end
    return vacant_rooms
  end

  # As an administrator, I can access the list of all of the rooms in the hotel
  def view_all_rooms
    return @rooms
  end

  #As an administrator, I can access the list of reservations for a specific date
  # I do not have to return a reservation that has specific date at the end
  # In my program, the reservations have real checkout date
  # In my program, the room class have real dates, not including the last check out date
  # REFACTOR idea: to keep take out -1 day when you load reservation, but reservations calculates the cost based of nights - I wil have to fix that too
  def find_reservations(date)
    date = Time.parse(date)
    reservations = @reservations.select do |instance|
      start_date = instance.start_time
      end_date = instance.end_time
      end_date = end_date - 1
      if date_in_range(start_date, end_date, date)
        instance
      end
    end
    return reservations
  end

  #As an administrator, I can get the total cost for a given reservation
  #input is a reservation instance
  def find_cost(reservation)
    cost = reservation.cost
    return cost
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
  #expect input to be time instances
  def create_hotel_range(start_date, end_date)
    end_date = end_date - 1
    range = (start_date .. end_date)
    return range
  end

  # expects input to be time instances
  def create_array_of_dates(start_date, end_date)
    dates = []
    difference = end_date - start_date
    difference = difference/86400
    difference.to_i.times do |i|
      dates << start_date + (1+i)
    end
    return dates
  end

  private
  #never used currently
  def sort_reservations
    @reservations.sort_by { |object| object.start_time }
  end

  def intersection(range, range2)
    if (range.max < range2.begin or range2.max < range.begin)
        return nil
    else
        return [range.begin, range2.begin].max..[range.max, range2.max].min
    end
  end

  def date_in_range(start_date, end_date, date)
    range = (start_date .. end_date)
    range.include?(date)
  end

  # find range in an array of ranges,
  #NOT USEFUL you need to check every day in the range not just that the ranges are not equal
  def range_search(ranges, target)
    ranges.each do |range|
      if range == target
        return true
      end
    end
    return false
  end
end
