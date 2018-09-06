require 'csv'
require 'pry'

class Admin
  attr_reader :reservations, :find_reservation
  def initialize
    @reservations = load_reservations('spec/test_data/test_reservation.csv')
    sort_reservations
  end

  def load_reservations(filename)
    reservations = []

    CSV.read(filename, headers: true).each do |line|
      data = line.to_h
      input_data = {}
      input_data[:id] = data["id"].to_i
      input_data[:start_time] = Time.parse(data["start_time"])
      input_data[:end_time] = Time.parse(data["end_time"])
      reservations << Reservation.new(input_data)
    end

    return reservations
  end
  #As an administrator, I can access the list of reservations for a specific date
  def find_reservations(date)
    date = Time.parse(date)
    reservations = @reservations.select do |instance|
      start_date = instance.start_time
      end_date = instance.end_time
      if date_in_range(start_date, end_date, date)
        instance
      end
    end
    return reservations
  end

  #As an administrator, I can get the total cost for a given reservation
  def find_cost(reservation_id)
    reservation = @reservations.select { |instance| instance.id == reservation_id }[0]
    cost = reservation.cost
    return cost
  end

  private
  def sort_reservations
    @reservations.sort_by { |object| object.start_time }
  end

  def date_in_range(start_date, first_date, date)
    range = (start_date..first_date)
    range.include?(date)
  end
end
