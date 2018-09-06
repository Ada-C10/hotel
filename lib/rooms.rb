class Rooms

  def initialize
    @rooms = []
    (1..20).each do |num|
      @rooms << Hotel::Room.new(num)
    end
    @reservations = []

    end


rooms = { #20 key-value pairs. reservations stored in array of hashes
  1: [
        {
          "check_in": "2010-05-28",
          "check_out": "2010-05-30"
        },
        {
          "start_date": "2010-06-28",
          "end_date": "2010-06-30"
        }
      ],

  2: [
        {
          "start_date": "check_in",
          "end_date": "check_out"

        }
      ],
}
