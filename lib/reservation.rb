class Reservation
  #Date.parse('2001-02-03')
  attr_reader :check_in, :check_out, :room_num
  def initialize(check_in, check_out, room_num)
    @check_in = check_in
    @check_out = check_out
    @room_num = room_num

    if @check_in.class != Date
      @check_in = Date.parse(check_in)
    end
    if @check_out.class != Date
      @check_out = Date.parse(check_out)
    end
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

  def date(date)
    if @check_in.class != Date
      date = Date.parse(date)
    end

    if (@check_in..@check_out).to_a.include?(date)
      return self
    end
  end
end
