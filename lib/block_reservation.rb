module Hotel
  class BlockReservation < Reservation
    attr_reader :group_name, :number_of_rooms, :status
    def initialize(id, guest_name, included_rooms, rsv_start, rsv_end, group_name, number_of_rooms, status = :BLOCK)
      super(id, guest_name, included_rooms, rsv_start, rsv_end, status)
      @group_name = group_name
      @number_of_rooms = number_of_rooms
      @status = status
    end




  end # class
end # module

