require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'room'
require_relative 'admin'

class Block < Admin
  attr_reader :discount, :block_name

  def initialize(name, room_id_list, start_date, end_date, discounted_rate)
    super(room_id_list, start_date, end_date)
    @discount = discounted_rate
    @block_name = name
  end

  def calculate_cost(reservation_id)
    return find_reservation(reservation_id).reserve_cost * (1-@discount)
  end

  def make_reservation(reservation_id,customer_name)
    super(reservation_id,customer_name, start_date, end_date)

  end

end
