require 'pry'
require 'date'
require_relative 'admin'
require_relative 'block_admin'

class Main
  #create 20 rooms for period today to one year later
  room_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
  start = Date.today
  last = start + 365
  work_space = Admin.new(room_list,start,last)
  work_space.create_room_block("block1",[1,2],Date.new(2018,10,1),Date.new(2018,10,3),0.1)
  work_space.room_blocks.first.make_reservation(1,"jessie")
  puts work_space.room_blocks.first.reservations.first
  puts work_space.room_blocks.first.reservations.first.customer_name
  puts work_space.room_blocks.first.reservations.first.room.room_num
  puts work_space.room_blocks.first.reservations.first.start_date
  puts work_space.room_blocks.first.reservations.first.end_date
end
