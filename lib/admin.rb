require 'Date'

class Admin
  def initialize
  @available_rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
  @reserved_rooms = []
  @reservation_id = 0
  end

  def view_available_rooms
    puts "AVAILABLE ROOMS:"
    puts @available_rooms
  end

  def reserve(number_of_rooms_needed)
      return @reserved_rooms
  end

  def view_current_reservations
    puts "RESERVED ROOMS"
    puts @reserved_rooms
  end

  def view_details_of_reservation(reservation_id)


  end

  def print_total_cost_per_reservation(reservation_id)
  end

  def calculate_number_of_days

  end
  def create_id

  end
  def cost(id)

  end
  def booking_details
  end

  def reservations_on_a_date()
end

class Room
  def initialize
  @available_rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
  @reserved_rooms = []
  @reservation_id = 0
  end
  def available_rooms

  end

  @cost

  def check_status()
  end

  def reserved_rooms
  end

  def reservation_list
  end
end

class Reservation
  @check_in_date
  @check_out_date
  @total_cost
  @user_id
  def available_rooms
  end

  def reserved_rooms
  end

  def reserve(number_of_rooms_needed)

    if number_of_rooms_needed > @available_rooms.length
      puts "We don't have enough rooms"
    else
      rooms_selected = (0..(@available_rooms.length-1)).to_a.sample(number_of_rooms_needed)
      number_of_rooms_needed.times do |i|
        @reserved_rooms << rooms_selected[i]
        @available_rooms.delete(rooms_selected[i])
      end
    end
      return @reserved_rooms
  end

  def calculate_number_of_days
    puts "What is your starting date yyyy-mm-dd"
    start_date_input = gets.chomp
    start_date = Date.parse(start_date_input)
    puts start_date
    puts "What is your ending date yyyy-mm-dd"
    end_date_input = gets.chomp
    end_date = Date.parse(end_date_input)
    puts end_date
    number_of_days = end_date - start_date
    return number_of_days.to_i
  end

  def create_id
    @@reservation_id += 1
    return @@reservation_id
  end
  def cost
    days = calculate_number_of_days
    return (days - 1) * 200
  end
end

# class BlockRooms
#   @rooms = []
#   @date_range
#   @cost
#end

#end
admi = Admin.new
admi.view_available_rooms
admi.reserve(4)
admi.view_available_rooms
puts admi.calculate_number_of_days
