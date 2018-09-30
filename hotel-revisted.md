## What is this class's responsibility? You should be able to describe it in a single sentence.
  * Room: Holds information on room type by id and cost 
  * Reservation: Holds information on each reservation, including start and end date, guest name, rooms included, status, booked dates and cost, it is responsible for determining the date range of the reservation and the total cost
  * BlockReservation:
  * BookingSystem: is able to load all the rooms, load all current reservations, find reservations by date, find reservation by date, find available rooms, make a reservation, and make a block reservation

## Is this class responsible for exactly one thing?
BookingSystem deals only with making and searching reservations

## Does this class take on any responsibility that should be delegated to "lower level" classes?
Determining total cost should be delegated only to the reservation class

## Is there code in other classes that directly manipulates this class's instance variables? no