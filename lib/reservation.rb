class Reservation
  attr_reader :name, :room_number, :check_in_date, :check_out_date, :nights_of_stay

  def initialize(input)
    @name = input[:name]
    @room_number = input[:room_number]
    @check_in_date = input[:check_in_date]
    @check_out_date = input[:check_out_date]
    @nights_of_stay = input[:nights_of_stay]
  end
end
