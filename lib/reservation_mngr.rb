module Hotel

  class Reservation_mngr
    attr_reader :rooms, :reservations

    def initialize
      @rooms = input[:rooms].nil? [] : input[:rooms]
      @reservations = input[:reservations].nil? [] : input[:reservations]
      @price = 200
    end

    def list_rooms
      # if @rooms == nil
      #   20.times do |i|
      #     @rooms << Hotel::Room.new({room_number: "#{i + 1}".to_i, price: 200})
      #   end
      #   return @rooms
    end

    def list_reservations
      #   return @reservations
    end

    def find_room(check_in, check_out)

    end

    def reserve_room

    end

    def get_total(reservation_id)
      
    end

  end

end
