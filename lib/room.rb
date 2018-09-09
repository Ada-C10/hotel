class Room
  attr_reader :room_num
  attr_accessor :reservations, :room_blocks

  def initialize(room_num: nil, reservations: [], room_blocks: [])
    @room_num = room_num
    @reservations = reservations
    @room_blocks = room_blocks
  end

  def is_available?(dates)
    @reservations.each do |reservation|
      dates.each do |date|
        if reservation.dates_booked.include?(date)
          return false
        end
      end
    end
    return true
  end

  def is_not_blocked?(dates)
    @room_blocks.each do |block|
      dates.each do |date|
        if block.dates_booked.include?(date)
          return false
        end
      end
    end
    return true
  end

  def add_reservation_to_room(reservation)
    self.reservations << reservation
  end

  def add_block_to_room(block)
    self.room_blocks << block
  end

end
