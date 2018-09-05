require 'csv'
require 'pry'

class Admin
  attr_reader :reservations
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

  def sort_reservations
    @reservations.sort_by { |object| object.start_time }
  end

  def find_reservation(date)
    @reservations.select {|instance| instance.start_time == start_time || instance.end_time == end_time}
  end

end
