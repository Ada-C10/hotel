## Wave Three: Blocks of Rooms

If you are not familiar with what a block of hotel rooms, here is a brief description:

> A Block Booking refers to a group of rooms set aside for a specific group of customers for a set period of time.
>
> Room blocks are commonly created for large events like weddings or conventions. A number of rooms are set aside, and are made available for reservation by certain customers at a discounted rate. These rooms are not available to be reserved by the general public.

### User Stories

- As an administrator, I can create a block of rooms
    - To create a block you need a date range, collection of rooms and a discounted room rate
    - The collection of rooms should only include rooms that are available for the given date range
    - If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
- As an administrator, I can check whether a given block has any rooms available
- As an administrator, I can reserve a room from within a block of rooms

is a reservation a specialized block?

a block takes: daterange, room numbers
 (potentially hashes)
a reservation has status: public, block,  
a book has a new method for making a block reservation

the new_reservation method has to check


### Constraints

- A block can contain a maximum of 5 rooms
- When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
- All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
