require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'room'
require_relative 'admin'

class BlockAdmin < Admin
  attr_reader :discount

  def initialize(room_id_list, start_date, end_date, discounted_rate)
    super(room_id_list, start_date, end_date)
    @discount = discounted_rate
  end

  def calculate_cost(reservation_id)
    return find_reservation(reservation_id).reserve_cost * @discount
  end
end
