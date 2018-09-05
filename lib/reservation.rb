class Reservation
  #Date.parse('2001-02-03')
  attr_reader :check_in, :check_out, :room_num
  def initialize(check_in, check_out, room_num)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @room_num = room_num

    if @check_out < @check_in
      raise ArgumentError.new('The check-out date is before the check-in')
    end
    if @room_num <= 0 || @room_num > 20
      raise ArgumentError.new('That is not a valid room number')
    end
  end


  def cost
    cost_per_night = 200
    nights = (check_out - check_in).to_i

    total_cost = cost_per_night * nights

    return total_cost

  end

end
