
class Reservation
  attr_reader :room
  attr_reader :check_in
  attr_reader :check_out

  def initialize(room, check_in, check_out)
    @room = room
    @check_in = check_in
    @check_out = check_out

  end

end
