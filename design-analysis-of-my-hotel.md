#What is this class's responsibility?
ROOM class: it keeps track of the rooms are reserved in a block reservation or in a regular reservation
Behaviors:
-it adds the range to the instance variable range
-it adds the block to the instance variable block
-it adds the reservation status of "booked" to the block variable instance

RESERVATION class: it calculates cost of a reservation by creating instance variables

ADMIN class: It holds the rooms and the reservations, checks if rooms are available for block reservations or regular reservations, and provides views for current reservations.
Behaviors:
-it creates the rooms instances
-it creates the reservation instances
-it reserves a room by calling the methods in the ROOM class
-it views vacant rooms by reading the instance variable "ranges" of the ROOM class ---improve here
-it views all the rooms by reading it's instance variable: rooms
-it finds a reservation by reading it's instance variable: reservation
-it finds the cost of a reservation by reading the instance variable of the RESERVATION class.
-it creates a block of rooms, by modifying the block instance variable of the ROOM class --- improve here
-it finds vacant rooms available for a block by reading the instance variable, ranges, of the ROOM class --- improve here
-it reserves a room in a block by modifying the block instance variable of the ROOM class --- improve here

#Is this class responsible for exactly one thing?
ROOM class: not sure. I think no because it keeps track of blocks and regular reservation, and reserves rooms; but it doesn't change the instance variable of other classes so it is loosely coupled.
RESERVATION class: yes
ADMIN class: no (it checks if two reservations clashes before calling the reservation method in the ROOM class)

#Does this class take on any responsibility that should be delegated to "lower level" classes?
ROOM class: no
RESERVATION class: no
ADMIN class: yes, viewing vacant rooms should be moved to the ROOM class, creating a block of rooms should be moved to the ROOM class, and reserving a room should be move to the ROOM class

#Is there code in other classes that directly manipulates this class's instance variables?
ROOM class: yes, range and block are modified by methods in the ADMIN class (create block of rooms, and reserve a room)
RESERVATION class: no
ADMIN: no
