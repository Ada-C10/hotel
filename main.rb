require 'colorize'
require 'date'

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

def create_block(reservation_tracker)
  puts "\nPlease enter the following info to create a Block ~~".red

  print "\nPlease Enter a Party Size".red
  print "\n(Cannot be more than #{MAX_BLOCK_NUM}): ".red
  party = gets.chomp.to_i

  print "\nPlease Enter a Valid Start Date".red
  print "\n(YYY-MM-DD)".red
  print "\nDate: ".red
  start_date = gets.chomp

  print "\nPlease Enter a Valid End Date".red
  print "\n(YYY-MM-DD)".red
  print "\nDate: ".red
  end_date = gets.chomp

  input = {
    party: party,
    start_date: Date.parse(start_date),
    end_date: Date.parse(end_date)
  }
  reservation_tracker.block_rooms(input)
  new_block = reservation_tracker.blocks.last

  print "\n**********************************************".red
  puts"\nBlock Created!".red
  puts "Details Below!".red
  puts "\nBlock ID: #{new_block.id}".red
  puts "\nParty Size: #{new_block.party.length}".red
  puts "\nRooms Taken: ".red
  new_block.party.each do |room|
    print "\nRoom #: #{room.room_num} ".red
  end

  puts "\n\nStart Date: #{new_block.date_range.start_date}".red
  puts "End Date: #{new_block.date_range.end_date}".red
  puts ""
  print "\n**********************************************".red
end

def create_reservation(reservation_tracker)
  puts "\nPlease enter the following info to create a Reservation ~~".cyan

  print "\nPlease Enter a block ID if there is one".cyan
  print "\n(Otherwise please press ENTER if none): ".cyan
  block_id = gets.chomp

  if block_id == "nil" || ""
    block_id = nil
  else
    block_id = block_id.to_i
  end

  print "\nPlease Enter a Valid Start Date".cyan
  print "\n(YYY-MM-DD)".cyan
  print "\nDate: ".cyan
  start_date = gets.chomp

  print "\nPlease Enter a Valid End Date".cyan
  print "\n(YYY-MM-DD)".cyan
  print "\nDate: ".cyan
  end_date = gets.chomp

  input = {
    block_id: block_id,
    start_date: Date.parse(start_date),
    end_date: Date.parse(end_date)
  }
  reservation_tracker.reserve_room(input)
  new_reservation = reservation_tracker.reservations.last


  print "\n**********************************************".cyan
  puts"\nReservation Created!".cyan
  print "\nDetails Below!".cyan
  puts "\nReservation ID: #{new_reservation.id}".cyan
  unless block_id.nil?
    puts "Block ID: #{new_reservation.block_id}".cyan
  end
  puts "Start Date: #{new_reservation.date_range.start_date}".cyan
  puts "End Date: #{new_reservation.date_range.end_date}".cyan
  puts ""
  print "\n**********************************************".cyan
end

def list_available_rooms(reservation_tracker)
  puts "\nFind AVAILABLE Rooms for a period (Start Date, End Date) ~~".green
  print "\nPlease Enter a Valid Start Date"
  print "\n(YYY-MM-DD)"
  print "\nDate: "
  start_date = gets.chomp
  print "\nPlease Enter a Valid End Date"
  print "\n(YYY-MM-DD)"
  print "\nDate: "
  end_date = gets.chomp
  date_range = Hotel::DateRange.new(start_date, end_date)
  available_rooms = reservation_tracker.find_available_rooms(date_range)
  print "\n**********************************************".light_blue

  if available_rooms.empty?
    puts "\nThere are no available rooms for #{start_date} - #{end_date}".light_blue
  else
    puts "\nHere are the AVAILABLE Room(s) for #{start_date} - #{end_date}".light_blue
    available_rooms.each do |room|
      puts "\nRoom Number: #{room.room_num}".light_blue
    end
  end
  puts ""
  print "\n**********************************************".light_blue
end

def list_unavailable_rooms(reservation_tracker)
  puts "\nFind N/A Rooms for a period (Start Date, End Date) ~~".green
  print "\nPlease Enter a Valid Start Date"
  print "\n(YYY-MM-DD)"
  print "\nDate: "
  start_date = gets.chomp
  print "\nPlease Enter a Valid End Date"
  print "\n(YYY-MM-DD)"
  print "\nDate: "
  end_date = gets.chomp
  date_range = Hotel::DateRange.new(Date.parse(start_date), Date.parse(end_date))
  unavailable_rooms = reservation_tracker.find_unavailable_rooms(date_range)
  print "\n**********************************************".green

  if unavailable_rooms.empty?
    puts "\nAll rooms are AVAILABLE for #{start_date} - #{end_date}".green
  else
    puts "\nHere are the Unavailable Room(s) for #{start_date} - #{end_date}".green
    unavailable_rooms.each do |room|
      puts "\nRoom Number: #{room.room_num}".green
    end
  end
  puts ""
  print "\n**********************************************".green
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
    end
    puts ""
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
