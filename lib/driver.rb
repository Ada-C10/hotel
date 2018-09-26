# NO LONGER RELEVANT AFTER REFACTORING

# # Jacquelyn Cheng - Nodes
#
# # Driver: CLI for Hotel program
#
# require 'terminal-table'
# require 'colorize'
# require 'date'
# require_relative 'admin'
# require_relative 'block'
# require_relative 'reservation'
# require_relative 'room'
#
# def main
#   admin = Hotel::Admin.new
#   input = ""
#   until input.casecmp? "exit" || input == 7
#     main_menu
#     print "Enter a command: ".colorize(:green)
#     input = gets.chomp
#     case input
#     when "1", "Create a reservation"
#       create_res(admin)
#     when "2", "Create a room block"
#       create_block(admin)
#     when "3", "List rooms available for date(s)"
#       list_avail_rooms(admin)
#     when "4", "List reservations on date"
#       list_res(admin)
#     when "5", "Get cost of reservation"
#       res_lookup(admin)
#     when "6", "Find an existing block"
#       block_lookup(admin)
#     when "7", "Exit"
#       exit!
#     end
#   end
# end
#
# def main_menu
#   rows = []
#   rows << ["1", "Create a reservation"]
#   rows << ["2", "Create a room block"]
#   rows << ["3", "List rooms available for date(s)"]
#   rows << ["4", "List reservations on date"]
#   rows << ["5", "Get cost of reservation"]
#   rows << ["6", "Change room rate"]
#   rows << ["7", "Exit"]
#
#   table = Terminal::Table.new
#   table.headings = ["Command".colorize(:green), "Description".colorize(:green)]
#   table.rows = rows
#   puts table
#   puts
# end
#
# def create_res(admin)
#   begin
#     rows = []
#     puts "\nENTER RESERVATION DETAILS:".colorize(:blue)
#     print "Check-in date (YYYY-MM-DD): ".colorize(:blue)
#     checkin_date = Date.parse(gets.chomp)
#     rows << ["Check-in date", checkin_date]
#     print "Check-out date (YYYY-MM-DD): ".colorize(:blue)
#     checkout_date = Date.parse(gets.chomp)
#     rows << ["Check-out date", checkout_date]
#     print "Part of a block? (Y/N): ".colorize(:blue)
#     block_res = gets.chomp.upcase
#     if block_res == "Y" || block_res == "YES"
#       print "Block name (hit enter if not applicable): ".colorize(:blue)
#       block_name = gets.chomp
#       rows << ["Block name", block_name]
#       @
#       res = admin.reserve_room(checkin_date, checkout_date, block: block)
#     else
#       res = admin.make_reservation(checkin_date, checkout_date, room_quantity)
#     end
#     puts
#     table = Terminal::Table.new
#     table.title = "RESERVATION #{res.confirmation_number}".colorize(:blue)
#     table.rows = rows
#     puts table
#     puts
#   rescue ArgumentError => message
#     puts "Unable to create reservation: #{message}"
#   rescue Hotel::RoomAvailabilityError => message
#     puts "#{message} - Try again with different dates or room quantity."
#   end
# end
#
# def create_block(admin)
#   begin
#     rows = []
#     puts "\nENTER BLOCK DETAILS:".colorize(:blue)
#     print "Block name: ".colorize(:blue)
#     block_name = gets.chomp
#     print "Check-in date (YYYY-MM-DD): ".colorize(:blue)
#     checkin_date = Date.parse(gets.chomp)
#     rows << ["Check-in date", checkin_date]
#     print "Check-out date (YYYY-MM-DD): ".colorize(:blue)
#     checkout_date = Date.parse(gets.chomp)
#     rows << ["Check-out date", checkout_date]
#     print "Discount rate: ".colorize(:blue)
#     discount_rate = gets.chomp.to_f.round(2)
#     rows << ["Discount rate", discount_rate]
#     print "Number of rooms (1-5): ".colorize(:blue)
#     room_quantity = gets.chomp.to_i
#     rows << ["Room quantity", room_quantity]
#     admin.make_block(block_name, checkin_date, checkout_date, discount_rate, room_quantity)
#     puts
#     table = Terminal::Table.new
#     table.title = "#{block_name.upcase}".colorize(:blue)
#     table.rows = rows
#     puts table
#     puts
#   rescue ArgumentError => message
#     puts "Unable to create block: #{message}"
#   rescue RoomAvailabilityError => message
#     puts "#{message} - Try again with different dates or room quantity."
#   end
# end
#
# def list_avail_rooms(admin)
#   print "Enter date: ".colorize(:blue)
#   date = Date.parse(gets.chomp)
#   rooms = admin.list_available_rooms(date)
#   rows = []
#   rooms.each do |room|
#     rows << [room.room_num, room.nightly_rate(date)]
#   end
#   puts
#   table = Terminal::Table.new
#   table.title = "AVAILABLE ROOMS".colorize(:blue)
#   table.rows = rows
#   table.headings = ["Room".colorize(:blue), "Rate".colorize(:blue)]
#   puts table
#   puts
# end
#
# def list_res(admin)
#   print "Enter date: ".colorize(:blue)
#   date = Date.parse(gets.chomp)
#   reservations = admin.list_reservations(date)
#   rows = []
#   reservations.values.each do |res|
#     rows << [res.confirmation_number, res.checkin_date, res.checkout_date, res.rooms.length]
#   end
#   puts
#   table = Terminal::Table.new
#   table.title = "RESERVATIONS ON #{date.to_s.upcase}".colorize(:blue)
#   table.rows = rows
#   table.headings = ["Confirmation Number".colorize(:blue),
#     "Check-in Date".colorize(:blue),
#     "Check-out Date".colorize(:blue),
#     "Number of Rooms".colorize(:blue)]
#   puts table
#   puts
# end
#
# def res_lookup(admin)
#   print "Enter confirmation number: ".colorize(:blue)
#   conf = gets.chomp.to_i
#   puts
#   res = admin.find_reservation(conf)
#   rows = []
#   rows << ["Check-in date", res.checkin_date]
#   rows << ["Check-out date", res.checkout_date]
#   rows << ["Room quantity", res.rooms.length]
#   table = Terminal::Table.new
#   table.title = "RESERVATION: #{conf}".colorize(:blue)
#   table.rows = rows
#   puts table
#   puts
# end
#
# def block_lookup(admin)
#   print "Enter block name: ".colorize(:blue)
#   block_name = gets.chomp
#   puts
#   block = admin.find_block(block_name)
#   rows = []
#   rows << ["Check-in date", block.checkin_date]
#   rows << ["Check-out date", block.checkout_date]
#   rows << ["Discount rate", block.discount_rate.round(2)]
#   rows << ["Available rooms", block.num_rooms_available]
#   table = Terminal::Table.new
#   table.title = "BLOCK: #{block_name.upcase}".colorize(:blue)
#   table.rows = rows
#   puts table
#   puts
# end
#
# main
