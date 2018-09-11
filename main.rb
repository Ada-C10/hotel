require 'colorize'
require 'pry'

require_relative 'lib/date_range'
require_relative 'lib/room'
require_relative 'lib/reservation'
require_relative 'lib/block'
require_relative 'lib/reservation_tracker'
require_relative 'lib/block'


def main(reservation_tracker)
  welcome
  # binding.pry
  print_reservations_list_by_date(reservation_tracker)
  # reservation_details(reservation_tracker)
  # continue?(reservation_tracker)
end

def print_reservations_list_by_date(reservation_tracker)
  puts "What date would you like to look up?"
  print "Please type a valid date (YYY-MM-DD): "
  date = gets.chomp
  date_search = Date.parse(date)
  reservations = reservation_tracker.list_reservations_by_date(date_search)
  if reservations.empty?
    puts "There are no reservations for #{date}"
  else

    puts "Here are the Reservations for #{date}"
    reservations.each do |reservation|
      print "| Reservation ID: #{reservation.id } | "
      print reservation.block_id != nil ?  "Block ID: #{reservation.block_id.id} | " :  "Block ID: N/A | "
      print "Room Num: #{reservation.room.room_num} | "
      print "Total Cost: #{reservation.cost.to_f.round(2)} | "
      puts ""



    end
  end
end


def goodbye
  puts "\n~*~***~GOODBYE!~***~*~".yellow
  exit
end

def welcome
  puts "\n~*~*~*~~~**Welcome to The Reservation Tracker Info Page!**~~~*~*~*~\n".magenta
end


reservation_tracker = Hotel::ReservationTracker.new
main(reservation_tracker)
