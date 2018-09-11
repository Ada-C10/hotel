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
  user_options?(reservation_tracker)
end

def continue?(reservation_tracker)
  puts ""
  print "What would you like to do next?"
  puts ""
  user_options?(reservation_tracker)
end

def user_options?(reservation_tracker)
  print "\n**********************************************".magenta
  print "\n~*~*~*~*~*~*~*~*~USER OPTIONS~*~*~*~*~*~*~*~*~".magenta
  print "\n**********************************************".magenta
  puts "\n1. Search for Reservations (by date)"
  puts "\n2. List Unavailable Rooms (by date range)"
  puts "\n3. List Available Rooms (by date range)"
  puts "\n4. Create a New Reservation"
  puts "\n5. Create a new Block"
  puts "\n6. Exit!"
  print "\n**********************************************".yellow
  print "\nPlease enter a valid Number (1-6): ".yellow
  option = gets.chomp
  print "\n**********************************************".yellow
  puts ""
  user_decision(option, reservation_tracker)
  continue?(reservation_tracker)
end

def user_decision(option, reservation_tracker)
  case option
  when "1"
    print_reservations_list_by_date(reservation_tracker)
  when "2"
    list_unavailable_rooms(reservation_tracker)
  when "3"
    list_available_rooms(reservation_tracker)
  when "4"
    create_reservation(reservation_tracker)
  when "5"
    create_block(reservation_tracker)
  when "6", 'exit'
    goodbye
  end
end

def print_reservations_list_by_date(reservation_tracker)
  puts "\nFind Reservation By Date ~~".blue
  print "\nPlease Enter a Valid Date"
  print "\n(YYY-MM-DD)"
  print "\nDate: "
  date = gets.chomp
  date_search = Date.parse(date)
  reservations = reservation_tracker.list_reservations_by_date(date_search)
  print "\n**********************************************".blue

  if reservations.empty?
    puts "\nThere are no reservations for #{date}"
  else
    puts "\nHere are the Reservations for #{date}".blue
    reservations.each do |reservation|
      print "| Reservation ID: #{reservation.id } | ".blue
      print reservation.block_id != nil ?  "Block ID: #{reservation.block_id.id} | ".blue :  "Block ID: N/A | ".blue
      print "Room Num: #{reservation.room.room_num} | ".blue
      print "Total Cost: #{reservation.cost.to_f.round(2)} | ".blue
      puts ""
    end
    print "\n**********************************************".blue
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
