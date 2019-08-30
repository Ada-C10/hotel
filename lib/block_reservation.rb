module Hotel
  class BlockReservation < Reservation
    attr_reader :group_name, :status, :room_qty
    attr_accessor :block_rsv
    def initialize(input)
      super(input)
      raise ArgumentError, 'Invalid name' if input[:group_name].nil? || input[:group_name].empty?
      raise ArgumentError, 'Invalid # of rooms' if input[:room_qty].to_i < 2 || input[:room_qty].to_i > 5
      @included_rooms = input[:included_rooms]
      @block_rsv = rsv_hash
      @group_name = input[:group_name]
      @room_qty = input[:room_qty].to_i
      @status = :BLOCK
      @total_cost = get_total_cost(input[:included_rooms],
                                   Date.parse(input[:rsv_start]),
                                   Date.parse(input[:rsv_end]),
                                   @status)
    end

    # create a hash with rooms as keys and guest_name as value, set all to
    # pending until a room is reserved within a block
    def rsv_hash
      @block_rsv = Hash[@included_rooms.collect { |room| [room, 'pending'] }]
    end
  end # class
end # module

