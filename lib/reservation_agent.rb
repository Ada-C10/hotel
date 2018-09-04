require 'date'

require_relative 'reservation_maker'
require_relative 'reservation_tracker'

class ReservationAgent
  attr_reader :reservation_maker, :reservation_tracker

  def initialize(reservation_maker, reservation_tracker)
    @reservation_maker = reservation_maker
    @reservation_tracker = reservation_tracker
  end

end
