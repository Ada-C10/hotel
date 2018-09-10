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
      room_new = create_room(i)
      @rooms << room_new
      start_d = start_date

      while start_d < end_date

        @room_unbooked_dates << {room_n: room_new, unbooked_date: start_d}
        start_d += 1
      end
    end
  end

  # find availabe rooms in a given period
  def find_room_available(start_date, end_date)

    check_input_dates(start_date, end_date)
    dates_available_rooms = []

    @rooms.each do |room|
      dates_needed = []
      start_d = start_date

      while start_d < end_date
        dates_needed << {room_n: room, unbooked_date: start_d}
        start_d += 1
      end

      if (@room_unbooked_dates & dates_needed) == dates_needed
        dates_available_rooms << room
      end
    end
    return dates_available_rooms
  end

  # make new reservations
  def make_reservation(reservation_id, customer_name, start_date, end_date)

    check_input_dates(start_date, end_date)
    if start_date < @start_date || (end_date > @end_date)
      raise ArgumentError, "can only book reservations between #{@start_date} and #{@end_date}"
    end

    rooms_not_booked = find_room_available(start_date, end_date)

    if rooms_not_booked == []
      raise ArgumentError, "No room available at this time."
    else
      room = rooms_not_booked.first
    end

    result = create_reservation(reservation_id, customer_name, room, start_date, end_date)
    @reservations << result
    start_d = start_date

    while start_d < end_date
      @room_unbooked_dates.reject! {|item| item == {room_n: room, unbooked_date: start_d}}
      start_d += 1
    end

    return result
  end

  # create room blocks
  def create_room_block(name_of_block, room_collection, start_date, end_date, discount_rate)
    if discount_rate < 0 || discount_rate > 1
      raise ArgumentError
    end

    if  room_collection.nil? || room_collection == [] || room_collection.length > 5
      raise ArgumentError, "room list can not be nil, empty array or more than 5 in the list"
    end

    if start_date.class != Date || end_date.class != Date
      raise ArgumentError, "start_date and end_Date should be Date objects"
    end
    if start_date >= end_date
      raise ArgumentError, "invlid dates entered, start_date should be ealier than end_date"
    end

    if start_date < @start_date || end_date > @end_date
      raise ArgumentError, "start_date and end_date of room block must be in the working period"
    end

    available_rooms = find_room_available(start_date, end_date)
    room_entered = room_collection.map {|item| find_room(item)}

    if (available_rooms & room_entered) != room_entered
      raise ArgumentError, "rooms are not available in given period"
    else
      start_d = start_date
      # room_entered.each do |room|
      #   while start_d < end_date
      #     @room_unbooked_dates.reject! {|item| item == {room_n: room, unbooked_date: start_d}}
      #     start_d += 1
      #   end
      # end
      date_list = []
      while start_d < end_date
        date_list << start_d
        start_d += 1
      end

      room_date_list = []
      date_list.each do |item|
        room_entered.each do |r|
         room_date_list << {room_n: r, unbooked_date: item}
        end
      end

      @room_unbooked_dates = @room_unbooked_dates - room_date_list
    end



    new_block = create_block_admin(name_of_block,room_collection, start_date, end_date, discount_rate)
    room_blocks << new_block
    return new_block

  end

  # input a string of date, to return the list of the reservations on that date
  def list_reservations(date_selected)
    return @reservations.select {|reserve| reserve.dates_booked.include? date_selected}

  end

  # find room obj by id
  def find_room(id)
    raise ArgumentError, "ID cannot be blank, less than zero or more than 20. (got #{id})" if id.nil? || id <= 0 || id > 20
    return @rooms.find { |room| room.room_num == id }
  end

  # find reservation obj by id
  def find_reservation(id)
    raise ArgumentError, "ID cannot be blank or less than zero. (got #{id})" if id.nil? || id <= 0
    return @reservations.find {|reserve| reserve.id == id }

  end

  # calculate reservation cost by reservation id
  def calculate_cost(reservation_id)

    return find_reservation(reservation_id).reserve_cost

  end

  private
    # check inputed start_date and end_date to make sure they are valid
    def check_input_dates(start_date, end_date)
      if start_date.class != Date || end_date.class != Date
        raise ArgumentError, "start_date and end_Date should be Date objects"
      end
      if start_date >= end_date
        raise ArgumentError, "invlid dates entered, start_date should be ealier than end_date"
      end
    end

   # create new instance of reservation object
    def create_reservation(reservation_id, customer_name, room, start_date, end_date)
      return Reservation.new(reservation_id, customer_name, room, start_date, end_date)
    end

    # create new room object
    def create_room(id)
      return Room.new(id)
    end

   # create new room_block admin object
    def create_block_admin(name, room_id_list, start_date, end_date, discount_rate)
      return BlockAdmin.new(name, room_id_list, start_date, end_date, discount_rate)
    end
end
