# User Stories

## Requirements

- As an administrator, I can access the list of all of the rooms in the hotel
- As an administrator, I can reserve a room for a given date range
- As an administrator, I can access the list of reservations for a specific date
- As an administrator, I can get the total cost for a given reservation
- Your code should raise an error ([StandardError](https://ruby-doc.org/core-2.5.0/StandardError.html)) when an invalid date range is provided

- The hotel has 20 rooms, and they are numbered 1 through 20
- Every room is identical, and a room always costs $200/night
- The last day of a reservation is the checkout day, so the guest should not be charged for that night
- For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)

## Design


<!-- - ruby returns array of all rooms
    - rooms are a hash
        - key1 = :room_number (1-20) make them symbols! (don't make anything dependent on this being an integer!)
        - key2 = :room_rate (float = 200.0)
    - is it easy for 200 to become a default later?
    - the block cost can go in the args hash!
    - is it easy for this hash to become a class later? -->
- provide :start_date and :end_date
    - later, reservation class comes up with a room number
    - ruby makes a reservation object
        - :start_date
        - :end_date
        - :room_number (default to default, define default as room 1)
- provide :date
        - book class contains reservations []
  -  (argument is number of rooms) ##### really?
        <!-- - hotel class can return a list of all rooms -->
        - book class searches reservations by date
    - book class returns array of reservations for that date
- provide reservation
    - ruby returns number of nights to charge
        - reservation class calculates duration
        - WHICH CLASS KNOWS TO CHARGE DURATION-1 NIGHTS? ######
    - cost class multiplies nights by room cost
        - reservation shouldn't know anything about cost -- cost class
    - ruby returns float of total cost
- provide date range
    - reservation class determines if it's valid (start before end) or not
    - if invalid, ruby raises StandardError



## Thoughts

can I do this without a room class? what would a room class do?
