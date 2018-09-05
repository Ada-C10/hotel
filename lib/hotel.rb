# hotel/lib/hotel.rb

# Nessary files - do not remove
require "time"
require "date" # not necessary in my local envi
require_relative "room"
require_relative "reservation"

# Optional files - for developer use
require "pry"
require "awesome_print"


## TODO:
# - As an administrator, I can access the list of all of the rooms in the hotel
# - As an administrator, I can reserve a room for a given date range
# - As an administrator, I can access the list of reservations for a specific date
# - As an administrator, I can get the total cost for a given reservation
# - Your code should raise an error ([StandardError](https://ruby-doc.org/core-2.5.0/StandardError.html)) when an invalid date range is provided

### Constraints
# - The hotel has 20 rooms, and they are numbered 1 through 20
# - Every room is identical, and a room always costs $200/night
# - The last day of a reservation is the checkout day, so the guest should not be charged for that night
# - For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
