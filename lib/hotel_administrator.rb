#Command Line interface for the Hotel
require_relative 'hotel'
require 'awesome_print'

hotel = Hotel.new

def menu
  puts "Hotel Management System"
  puts "Please select an option:
      1. List all rooms
      2. Reserve a room
      3. List reservations
      4. Reservation price
      5. List available rooms
      6. Create room block
      7. List block availability
      8. Reserve a blocked room
      9. Quit"
end

menu
input = gets.chomp

until  input == "9"
  case input
  when "1"
    ap hotel.show_all_room_numbers
  when "2"
    puts "please enter the customer name"
    customer = gets.chomp
    puts "please enter a checkin date"
    start_date = Date.parse(gets.chomp)
    puts "please enter a checkout date"
    end_date = Date.parse(gets.chomp)
    puts "please enter a room number"
    room_number = gets.chomp.to_i
    hotel.make_reservation(start_date, end_date, room_number, customer)
  when "3"
    ap hotel.reservations
  when "4"
    puts "please enter the reservation id of the reservation you'd like to check"
    reservation_id = gets.chomp.to_i
    puts "that reservation costs $#{hotel.find_reservation_price(reservation_id)}"
  when "5"
    puts "please enter a start date"
    start_date = Date.parse(gets.chomp)
    puts "please enter a checkout date"
    end_date = Date.parse(gets.chomp)
    puts "available rooms:"
    ap hotel.find_available_rooms(start_date, end_date)
  when "6"
    puts "please enter a code to identify this block (such as 'Stevens Wedding')"
    block_code = gets.chomp
    puts "how many rooms would you like to block?"
    number = gets.chomp.to_i
    room_number_list = []
    number.times do
      puts "enter a room number to add to the block"
      room_number_list << gets.chomp.to_i
    end
    puts "enter the discounted room rate in dollars (no cents)"
    discounted_rate = gets.chomp.to_i
    puts "enter the start date for this block"
    start_date = Date.parse(gets.chomp)
    puts "enter the checkout date for this block"
    end_date = Date.parse(gets.chomp)
    hotel.create_room_block(start_date, end_date, room_number_list, discounted_rate, block_code)
  when "7"
    puts "enter the block code of the block you'd like to investigate"
    block_code = gets.chomp
    ap hotel.find_available_block_rooms(block_code)
  when "8"
    puts "enter the block code for the room you'd like to reserve"
    block_code = gets.chomp
    puts "enter the room number you'd like to reserve"
    room_number = gets.chomp.to_i
    puts "enter the customer name for the reservation"
    customer = gets.chomp
    hotel.reserve_blocked_room(block_code, room_number, customer)
  end
  menu
  input = gets.chomp
end
