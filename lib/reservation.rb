
class Reservation
attr_reader :room
attr_reader :start_date
attr_reader :end_date

def initialize(room, start_date, end_date)
@room = room
@start_date = start_date
@end_date = end_date

end

end
