require_relative 'hotel'

def main

  hotel = Hotel.new(20)

  puts "What do you want to do?\n 1. List all the rooms\n 2. Reserve a room\n 3. List Reservations for a Date\n 4. Find a Reservation Cost\n 5. List Available Rooms for a Date Range\n 6. Create a Room Block\n 7. List Available Block Rooms\n 8. Reserve a Block Room\n 9. Exit"

  user_answer = gets.chomp.to_i
  answers = [1, 2, 3, 4, 5, 6, 8, 9]

  until user_answer == 9
    while !(answers.include? user_answer)
      puts "That is not an options. See above for your options or press 9 to exit"
      user_answer = gets.chomp.to_i
    end

    if user_answer == 1
      puts hotel.list_rooms

    elsif user_answer == 2
      puts "What is the start date? '2018-01-01' format"
      start_date = gets.chomp
      puts "What is the end date? '2018-01-01' format"
      end_date = gets.chomp
      puts "How many rooms?"
      number_of_rooms = gets.chomp.to_i

      hotel.reserve_room(start_date, end_date, number_of_rooms)
      puts "Your reservation ID is #{hotel.reservations[-1].reservation_id}"

    elsif user_answer == 3
      puts "What date do you want see reservations from? '2018-01-01' format"
      date = gets.chomp
      puts hotel.list_reservations(date)

    elsif user_answer == 4
      puts "Please input an ID for a reservation cost"
      res_id = gets.chomp
      puts hotel.reservation_cost(res_id)

    elsif user_answer == 5
      puts "What is the start date? '2018-01-01' format"
      start_date = gets.chomp
      puts "What is the end date? '2018-01-01' format"
      end_date = gets.chomp

      puts hotel.list_available_rooms(start_date, end_date)

    elsif user_answer == 6
      puts "What is the start date? '2018-01-01' format"
      start_date = gets.chomp
      puts "What is the end date? '2018-01-01' format"
      end_date = gets.chomp
      puts "How many rooms?"
      number_of_rooms = gets.chomp.to_i
      puts "What will the discounted rate be?"
      discounted_rate = gets.chomp.to_i

      hotel.create_room_block(start_date, end_date, number_of_rooms, discounted_rate)
      puts "Your room block ID is #{hotel.room_blocks[-1].block_id}"

    elsif user_answer == 7
      puts "Please input a block ID to list available block rooms"
      block_booking_id = gets.chomp
      puts list_available_block_rooms(block_booking_id)

    elsif user_answer == 8
      puts "Please input a block ID to reserve a block room"
      block_booking_id = gets.chomp
      puts "How many rooms are you reserving?"
      number_of_rooms = gets.chomp.to_i
      reserve_block_room(block_booking_id, number_of_rooms)
    elsif user_answer == 9
      exit
    end
    puts "What do you want to do next? See above for your options or press 9 to exit."
    user_answer = gets.chomp.to_i
  end
  exit
end

main
