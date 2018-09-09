require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'room'


class Admin
  attr_reader :reservations, :rooms, :room_unbooked_dates, :room_blocks, :start_date, :end_date

  def initialize(room_id_list, start_date, end_date)
    check_input_dates(start_date, end_date)
    @rooms = []
    @reservations = []
    @room_unbooked_dates = []
    @room_blocks =[]
    @start_date = start_date
    @end_date = end_date

    room_id_list.each do |i|
      room_new = Room.new(i)
      @rooms << room_new
      start_d = start_date

      while start_d < end_date

        @room_unbooked_dates << {room_n: room_new, unbooked_date: start_d}
        start_d += 1
      end
    end
  end

  def find_room_available(start_date, end_date)

    check_input_dates(start_date, end_date)
    dates_available_rooms = []

    @rooms.each do |room|
      dates_needed = []
      start_d = start_date

      while start_d <= end_date
        dates_needed << {room_n: room, unbooked_date: start_d}
        start_d += 1
      end

      if (@room_unbooked_dates & dates_needed) == dates_needed
        dates_available_rooms << room
      end
    end
    return dates_available_rooms
  end


  def make_reservation(reservation_id, customer_name, start_date, end_date)

    check_input_dates(start_date, end_date)
    if start_date < @start_date || (end_date > @end_date)
      raise ArgumentError, "can only book reservations between #{@start_date} and #{@end_date}"
    end

    rooms_not_booked = find_room_available(start_date, end_date)

    if rooms_not_booked == []
      return "No room available at this time."
    else
      room = rooms_not_booked.first
    end

    result = Reservation.new(reservation_id, customer_name, room, start_date, end_date)
    @reservations << result
    start_d = start_date

    while start_d < end_date
      @room_unbooked_dates.reject! {|item| item == {room_n: room, unbooked_date: start_d}}
      start_d += 1
    end

    return result
  end

  # create room blocks
  def create_room_block(name_of_block, room_collection, discounted_rate, start_date, end_date)
    # make sure room_collection.length are not more than 5
    # make sure rooms in collection are available with the given date range
    # raise argument error if the above is not structures
    # initialize a room_block_class object and put into the room ,block array
  end

  # input a string of date, to return the list of the reservations on that date
  def list_reservations(date_selected)
    return @reservations.select {|reserve| reserve.dates_booked.include? date_selected}

  end


  def find_room(id)
    raise ArgumentError, "ID cannot be blank, less than zero or more than 20. (got #{id})" if id.nil? || id <= 0 || id > 20
    return @rooms.find { |room| room.room_num == id }
  end

  def find_reservation(id)
    raise ArgumentError, "ID cannot be blank or less than zero. (got #{id})" if id.nil? || id <= 0
    return @reservations.find {|reserve| reserve.id == id }

  end

  def calculate_cost(reservation_id)

    return find_reservation(reservation_id).reserve_cost

  end

  private
    def check_input_dates(start_date, end_date)
      if start_date.class != Date || end_date.class != Date
        raise ArgumentError, "start_date and end_Date should be Date objects"
      end
      if start_date >= end_date
        raise ArgumentError, "invlid dates entered, start_date should be ealier than end_date"
      end
    end

end
