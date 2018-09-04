class Reservation
  #Date.parse('2001-02-03')
  attr_reader :check_in, :check_out, :room_num
  def initialize(check_in, check_out, room_num)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @room_num = room_num

    if @room_num <= 0 || @room_num > 20
      raise ArgumentError.new('That is not a valid room number')
    end
  end

  def find_room
  end

end
