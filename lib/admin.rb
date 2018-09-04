class Admin
  def initialize
  @available_rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
  @reserved_rooms = []
  @reservation_id
  end

  def view_available_rooms
    print "These are the available rooms:"
    print @available_rooms
  end

  def reserve(number_of_rooms_needed)

    if number_of_rooms_needed > @available_rooms.length
      print "We don't have enough rooms"
    else
      rooms_selected = (0..(@available_rooms.length-1)).to_a.sample(number_of_rooms_needed)
      number_of_rooms_needed.times do |i|
        @reserved_rooms << rooms_selected[i]
        @available_rooms.delete(rooms_selected[i])
      end
    end
      return @reserved_rooms
  end

  def view_current_reservations
    print @reserved_rooms
  end

  def view_details_of_reservation()
  end

  def print_total_cost_per_reservation(reservation_id)
  end

  def calculate_number_of_days()
end

# class Room
#   def available_rooms
#
#   end
#
#   @cost
#
#   def check_status()
#   end
#
#   def reserved_rooms
#   end
#
#   def reservation_list
#   end
# end

# class Reservation
#   @check_in_date
#   @check_out_date
#   @total_cost
#   @user_id
# end

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
