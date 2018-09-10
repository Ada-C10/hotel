require_relative 'room'
require_relative 'reservation'
require_relative 'block'
require 'pry'

NUMBER_OF_ROOMS = 20
STANDARD_ROOM_PRICE = 200.00

class TrackingSystem
  attr_reader :all_rooms, :reservations, :blocks

  def initialize
    @all_rooms = add_rooms
    @reservations = []
    @blocks = []
  end


  def add_rooms
    all_rooms = []
    NUMBER_OF_ROOMS.times do |i|
      i += 1
      i = Room.new({room_num: i, reserved_dates: []})
      all_rooms << i
    end
    return all_rooms
  end


  def view_all_rooms
    return @all_rooms
  end

  def view_reservations_on(date)
    raise ArgumentError.new"#{date} must be instance of Date" unless date.instance_of? Date
    all_reservations = []
    @reservations.each do |reservation|
      if (reservation.start_time...reservation.end_time).include?(date)
        all_reservations << reservation
      end
    end
    if all_reservations.empty?
      raise ArgumentError.new"There are no reservations on #{date}"
    else
      return all_reservations
    end
  end

  def total_cost_of_reservation(reservation)
    raise ArgumentError.new"#{reservation} must be instance of Reservation" unless reservation.instance_of? Reservation
    return reservation.total_cost
  end

  def view_available_rooms_on(start_time: Date.now, end_time: Date.now + 1)
    raise ArgumentError.new"start_time must be before end_time" unless start_time < end_time
    available_rooms = []
    unavailable_count = 0
    @all_rooms.each do |room|
      if room.reserved_dates.empty? && room.block == :NA
        available_rooms << room
      else
        room.reserved_dates.each do |dates_hash|
          if ranges_overlap?((dates_hash[:start_time]...dates_hash[:end_time]).to_a, (start_time..end_time).to_a) == false && room.block == :NA
            available_rooms << room
          else
            unavailable_count += 1
          end
        end
      end
    end
    if unavailable_count == NUMBER_OF_ROOMS
      raise ArgumentError.new"no rooms available on that date range"
    else
      return available_rooms
    end
  end


  def add_reservation(start_time: Date.now, end_time: Date.now + 1, number_of_rooms: 1)
    available_rooms = view_available_rooms_on(start_time: start_time, end_time: end_time)
    raise ArgumentError.new"Not enough rooms available on those dates" if available_rooms.length < number_of_rooms
    number_of_rooms.times do |i|
      @reservations << Reservation.new({room_num: available_rooms[i].room_num, start_time: start_time, end_time: end_time, price: 200.00})
      available_rooms[i].reserved_dates << {start_time: start_time, end_time: end_time}
    end
    @reservations
  end


  def add_block(start_time: Date.today + 7, end_time: Date.today.next_month, number_of_rooms: 5, discount: 10)
    raise ArgumentError.new"discount rate must be integer" unless discount.instance_of? Integer
    raise ArgumentError.new"start_time must be before end_time" unless start_time < end_time
    raise ArgumentError.new"number_of_rooms must be >= 1 && <= 5" unless number_of_rooms >= 1 && number_of_rooms <=5
    available_rooms = view_available_rooms_on(start_time: start_time, end_time: end_time)
    raise ArgumentError.new"not enough available rooms for this date range" if available_rooms.length < number_of_rooms
    block_id = generate_block_id.to_sym
    block = Block.new({rooms: [], start_time: start_time, end_time: end_time, discount: discount, block: block_id })
    number_of_rooms.times do |i|
      available_rooms[i].block = block_id
      block.rooms << available_rooms[i]
    end
    @blocks << block
    return @blocks
  end

  def retrieve_block_dates(block_id)
    raise ArgumentError.new"#{block_id} must be a Symbol" unless block_id.instance_of? Symbol
    dates_hash = {}
    range_array = []
    @blocks.each do |block|
      if block.block == block_id
        dates_hash[:start_time] = block.start_time
        dates_hash[:end_time] = block.end_time
        range_array = (dates_hash[:start_time]...dates_hash[:end_time]).to_a
      end
    end
    raise ArgumentError if dates_hash.empty?
    return range_array
  end

  def rooms_available_in_block(block_id)
    raise ArgumentError.new"#{block_id} must be a Symbol" unless block_id.instance_of? Symbol
    available_rooms = []
    @blocks.each do |individual_block|
      if individual_block.block == block_id
        individual_block.rooms.each do |room|
          if room.reserved_dates.empty?
            available_rooms << room
          else room.reserved_dates.each do |dates_hash|
            if (dates_hash[:start_time]...dates_hash[:end_time]).to_a.sort != retrieve_block_dates(block_id).sort
              available_rooms << room
            end
          end
        end
      end
    end
  end
  return available_rooms
end


 def add_reservation_in_block(start_time: Date.now, end_time: Date.now + 1, number_of_rooms: 1, block: :NA)
  available_rooms = rooms_available_in_block(block)
  raise ArgumentError.new"Not enough rooms available on those dates" if available_rooms.length < number_of_rooms
  discount = retrieve_block_discount(block)
  number_of_rooms.times do |i|
    @reservations << Reservation.new({room_num: available_rooms[i].room_num, start_time: start_time, end_time: end_time, price: STANDARD_ROOM_PRICE - (STANDARD_ROOM_PRICE * discount)})
    available_rooms[i].reserved_dates << {start_time: start_time, end_time: end_time}
  end
  @reservations
 end

 def retrieve_block_discount(block_id)
  discount = 0
  @blocks.length.times do |i|
    if @blocks[i].block == block_id
      discount = (@blocks[i].discount / 100)
    end #
  end
  return discount
 end


private

 def generate_block_id
  (0..3).map { (65 + rand(26)).chr }.join
 end

 def ranges_overlap?(r1, r2)
  r1.include?(r2.first) || r2.include?(r1.first)
 end



end
