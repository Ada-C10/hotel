require_relative 'reservation.rb'
require_relative 'booking_manager.rb'


class GroupReservations < Reservation
  attr_reader :room
  attr_accessor :check_in
  attr_accessor :check_out
  attr_reader :reservation_dates
  attr_accessor :group_name

  def initialize(room, check_in, check_out, group_name)
    super(room, check_in, check_out)
    @group_name = group_name
  end



end
