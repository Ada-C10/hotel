require 'time'
require 'date'

class BlockRoom

  def initialize(event_name, start_date, end_date)
    @event_name = event_name

    # start date must be entered in the format: yyyy,mm,dd
    parsed_start_date = start_date.split(",")
    start_year = parsed_start_date[0].to_i
    start_month = parsed_start_date[1].to_i
    start_day = parsed_start_date[2].to_i
    @starting_date = Date.new(start_year, start_month, start_day)

    # end date must be entered in the format: yyyy,mm,dd
    parsed_end_date = end_date.split(",")
    end_year = parsed_end_date[0].to_i
    end_month = parsed_end_date[1].to_i
    end_day = parsed_end_date[2].to_i
    @ending_date = Date.new(end_year, end_month, end_day)

    @rooms_blocked = []
  end

  # def add_room_to_block(room_num)
  # end

end
