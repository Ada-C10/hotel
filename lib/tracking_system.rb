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

  # Wave1 (1~4)
  # 1. As an administrator, I can access the list of all of the rooms in the hotel
  def view_all_rooms
    return @all_rooms
  end

  # 2. (wave 1 num 2 is the same as wave 2 num 2)
  # 3. As an administrator, I can access the list of reservations for a specific date
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

  # 4. As an administrator, I can get the total cost for a given reservation
  def total_cost_of_reservation(reservation)
    raise ArgumentError.new"#{reservation} must be instance of Reservation" unless reservation.instance_of? Reservation
    return reservation.total_cost
  end




  # Wave2 (1~2)
  # 1. As an administrator, I can view a list of rooms that are not reserved for a given date range
  def view_available_rooms_on(start_time: Date.now, end_time: Date.now + 1)
    raise ArgumentError.new"start_time must be before end_time" unless start_time < end_time
    #another test to create is making sure its an instance of Date
    available_rooms = []
    unavailable_count = 0
    @all_rooms.each do |room|
      if room.reserved_dates.empty? && room.block == :NA
        available_rooms << room
      else
        room.reserved_dates.each do |dates_hash| #<---date_range could be a hash like {checkin_time: checkin, checkout_time: checkout}
          if ranges_overlap?((dates_hash[:start_time]...dates_hash[:end_time]).to_a, (start_time..end_time).to_a) == false && room.block == :NA
            available_rooms << room #not quite sure how to write a test for this conditional, "ensures rooms not in a block", "ensures rooms dates dont overlap"
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

  #2. As an administrator, I can reserve an available room for a given date range
  #this method ONLY adds reservations for rooms that aren't in a block
  def add_reservation(start_time: Date.now, end_time: Date.now + 1, number_of_rooms: 1)
    available_rooms = view_available_rooms_on(start_time: start_time, end_time: end_time) #<--returns an array of available rooms that also aren't in a block
    raise ArgumentError.new"Not enough rooms available on those dates" if available_rooms.length < number_of_rooms
    number_of_rooms.times do |i|
      @reservations << Reservation.new({room_num: available_rooms[i].room_num, start_time: start_time, end_time: end_time, price: 200.00})
      available_rooms[i].reserved_dates << {start_time: start_time, end_time: end_time}
    end
    @reservations
  end


  # Wave3 (1~3)
  # 1. As an administrator, I can create a block of rooms
  # A block can contain a maximum of 5 rooms
  # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
  # To create a block you need a date range, collection of rooms and a discounted room rate
  # The collection of rooms should only include rooms that are available for the given date range
  # If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
  # All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
  def add_block(start_time: Date.today + 7, end_time: Date.today.next_month, number_of_rooms: 5, discount: 10)
    # raise ArgumentError.new"discount rate must be integer" unless discount.instance_of? Integer
    # raise ArgumentError.new"start_time must be before end_time" unless start_time < end_time
    raise ArgumentError.new"number_of_rooms must be >= 1 && <= 5" unless number_of_rooms >= 1 && number_of_rooms <=5
    available_rooms = view_available_rooms_on(start_time: start_time, end_time: end_time) #makes sure dates dont overlap and block status is :na
    raise ArgumentError.new"not enough available rooms for this date range" if available_rooms.length < number_of_rooms
    block_id = generate_block_id.to_sym
    block = Block.new({rooms: [], start_time: start_time, end_time: end_time, discount: discount, block: block_id })
    number_of_rooms.times do |i|
      available_rooms[i].block = block_id #assigns each room to this new block (by block_id)
      block.rooms << available_rooms[i] #shovels each room into the block
    end
    @blocks << block #puts new block in list of blocks
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
    return range_array #returns array of teh date range
  end
  # 2. As an administrator, I can check whether a given block has any rooms available
  def rooms_available_in_block(block_id) #block id
    raise ArgumentError.new"#{block_id} must be a Symbol" unless block_id.instance_of? Symbol
    available_rooms = []
    @blocks.each do |individual_block|
      if individual_block.block == block_id #if block id matches
        individual_block.rooms.each do |room| #find all rooms in that block( none of the rooms are reerved)
          if room.reserved_dates.empty?
            available_rooms << room
          else room.reserved_dates.each do |dates_hash| #see the reserved dates of each room
            if (dates_hash[:start_time]...dates_hash[:end_time]).to_a.sort != retrieve_block_dates(block_id).sort #checks if both date ranges are the same
              available_rooms << room
            end
          end
        end
      end
      return available_rooms
    end
  end
end
#i can combine this method with making a reservation if it returns a list of rooms available
#a block has a : start, end, rooms, discount, block(id)
#how do i get the discount rate applied?
# 3. As an administrator, I can reserve a room from within a block of rooms
def add_reservation_in_block(start_time: Date.now, end_time: Date.now + 1, number_of_rooms: 1, block: :NA) #block(id) defaults to :NA already but just clarifying here
  available_rooms = rooms_available_in_block(block) #<--returns an array of available rooms in this sepcifci block
  raise ArgumentError.new"Not enough rooms available on those dates" if available_rooms.length < number_of_rooms
  #call method taht gets block discount here
  discount = retrieve_block_discount(block)
  number_of_rooms.times do |i|
    # binding.pry
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
    else
      puts "hello "
    end
  end
  return discount
end
#create helper method that finds the block discount rate by block id?

private

def generate_block_id
  (0..3).map { (65 + rand(26)).chr }.join
end

def ranges_overlap?(r1, r2)
  r1.include?(r2.first) || r2.include?(r1.first)
end




end #class end




#############################  #############################   #############################
# private #helper methods below
# def view_two_dates_as_range()  #<--put params {checkin_time: checkin, checkout_time: checkout}
# def check_if_rooms_available_on(date_range) <--or does the view_available_rooms_on() already do this pretty much?

#############################  #############################   #############################
