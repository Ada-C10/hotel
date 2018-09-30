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
      # REFACTOR idea: make the reservation instance a separate method - isolating dependencies
      reservations << Reservation.new(input_data)
    end

    return reservations
  end

  #As an administrator, I can reserve a room for a given date range
  # uses view_vacant_rooms create range with one day less
  def reserve_room(start_date, end_date)
    start_date = Time.parse(start_date)
    end_date = Time.parse(end_date)
    range = create_hotel_range(start_date, end_date) # for hotel
    e_date = end_date - 1 # rooms do not keep track of last night
    vacant_rooms = view_vacant_rooms(start_date, e_date)
    if vacant_rooms.nil?
      # REFACTOR idea: begin rescue block, exception handleing
      raise StandardError, "no rooms are available"
    else
      room = vacant_rooms.first
      rooms.first.add_range(range)
      input_data = {}
      input_data[:start_time] = start_date
      input_data[:end_time] = end_date
      input_data[:room_num] = room.number
      reservations << Reservation.new(input_data)
    end
  end

  #As an administrator, I can view a list of rooms that are not reserved for a given date range
  ## expects dates to be instances of time
  def view_vacant_rooms(start_date, end_date)
    vacant_rooms = @rooms
    target_range = create_hotel_range(start_date, end_date)
    vacant_rooms.each do |room|
        ranges = room.ranges
        blocks = room.blocks
        ranges.each do |range|
            # nil means no intersection
            if intersection(target_range, range) != nil # there was a overlap
              vacant_rooms.delete(room)
              break
            end
        end
    end
    # remove rooms that have a block in them
    # must add test for this case
    vacant_rooms.each do |room|
      blocks = room.blocks
      blocks.each do |block|
        blocks.empty? == false
        vacant_rooms.delete(room)
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
  def create_block_rooms(data)
    start_date = Time.parse(data[:start_date])
    end_date = Time.parse(data[:end_date])
    e_date = end_date - 1
    range = (start_date..e_date)
    rooms = data[:rooms]
    raise StandardError if rooms > 5 #max block size
    discounted_rate = data[:discounted_rate]
    # view vacant_rooms - current method
    available_rooms = view_vacant_rooms_for_blocks(start_date, e_date)

    if available_rooms.length < rooms
      return "no available rooms for block"
    else
      max = rooms - 1 # because of the 0 index
      block_rooms = available_rooms[0 .. max]
      input_data = {}
      input_data[:discounted_rate] = discounted_rate
      input_data[:range] = range
      input_data[:status] = "available"
      block_rooms.each do |room|
        room.add_block(input_data)
      end
    end
  end

  def view_vacant_rooms_for_blocks(start_date, end_date)
    vacant_rooms = @rooms
    target_range = create_hotel_range(start_date, end_date)
    vacant_rooms.each do |room|
        ranges = room.ranges
        blocks = room.blocks
        ranges.each do |range|
            # nil means no intersection
            if intersection(target_range, range) != nil # there was a overlap
              vacant_rooms.delete(room)
              break
            end
        end
        blocks.each do |block|
            # nil means no intersection
            if intersection(target_range, blocks[:range]) != nil # there was a overlap
              vacant_rooms.delete(room)
              break
            end
        end
    end
    return vacant_rooms
  end

# As an administrator, I can reserve a room from within a block of rooms
  def reserve_room_in_block(data)
    room_num = data[:room_num]
    range = data[:range]
    room = @rooms.select { |room| room.number == room_num}[0]
    room.reserve_room_block(range)
    ### FUTURE WORK: 1. use method view_vacant_rooms_in_block before making a reservation
    # =>             2. create isntance of reservation
  end

  # As an administrator, I can check whether a given block has any rooms available
  def view_vacant_rooms_in_block(range)
    available_rooms = []
    block_rooms = find_block(range)
    block_rooms.each do |room|
      #blocks variable is an array
      blocks = room.blocks
      blocks.each do |block|
        if block[:status] == "available"
          available_rooms << room
        end
      end
    end
    return available_rooms
  end
  # it is used in view_vacant_rooms_in_block method
  def find_block(range)
    #find block
    rooms_with_blocks = @rooms.select { |room| room.blocks.empty? == false}
    #blocks variable are an array
    block_set = []
    rooms_with_blocks.each do |room|
      blocks = room.blocks
      blocks.each do |block|
        if block[:range] == range
          block_set << room
        end
      end
    end
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
