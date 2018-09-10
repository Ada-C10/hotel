module HotBook
# The Reservation class is responsible for calculating reservation cost
  class Reservation
    attr_reader :daterange, :room_number, :room_rate, :notes

    def initialize(daterange:, room_number:, room_rate:, notes: nil)
      @daterange = daterange
      @room_number = room_number
      @room_rate = room_rate
      @notes = notes
    end

# Does the reservation conflict with another reservation?
# Is this being used??
    def conflict?(other)
      return daterange.conflict? other.daterange
    end

    def duration
      return daterange.duration
    end

    def cost
      return duration * room_rate
    end

# Range only includes overnights and EXCLUDES checkout day.
    def range
      return daterange.to_range
    end

    def self.from_csv(filename)
      reservations = CSV.open(filename).map { |row|
        start_date = row[0]
        end_date = row[1]
        room_number = row[2]
        room_rate = row[3].to_f
        notes = row[4]

        HotBook::Reservation.new(
          daterange: HotBook::DateRange.new(start_date: start_date,
                                            end_date: end_date),
          room_number: room_number, room_rate: room_rate, notes: notes)
      }
      return reservations
    end
  end
end
