# Jacquelyn Cheng - Nodes

# Driver: CLI for Hotel program

require 'terminal-table'
require 'colorize'
require 'date'
require_relative 'admin'
require_relative 'block'
require_relative 'reservation'
require_relative 'room'

def main
  admin = Hotel::Admin.new
  input = ""
  until input.casecmp? "exit" || input == 9
    main_menu
    print "Enter a command: "
    input = gets.chomp
    case input
    when 1, "Create a reservation"
      create_res
    when 2, "Create a room block"
      create_block
    when 3, "List all rooms"
      list_rooms
    when 4, "List rooms available on date"
      list_avail_rooms
    when 5, "List reservations on date"
      list_res
    when 6, "Find an existing reservation"
      res_lookup
    when 7, "Find an existing block"
      block_lookup
    when 8, "Look up a room"
      room_lookup
    when 9, "Exit"
      exit!
    end
  end
end

def main_menu
  rows = []
  rows << ["1", "Create a reservation"]
  rows << ["2", "Create a room block"]
  rows << ["3", "List all rooms"]
  rows << ["4", "List rooms available on date"]
  rows << ["5", "List reservations on date"]
  rows << ["6", "Find an existing reservation"]
  rows << ["7", "Find an existing block"]
  rows << ["8", "Look up a room"]
  rows << ["9", "Exit"]

  table = Terminal::Table.new
  table.title = "HOTEL MANAGER: MAIN MENU".colorize(:green)
  table.headings = ["Command".colorize(:green), "Description".colorize(:green)]
  table.rows = rows
  table.style = {:width => 60, :all_separators => true,
    :border_x => "-".colorize(:black)}
  puts table
  puts
end

main
