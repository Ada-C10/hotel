require 'date'
require 'admin'


class Reservation
  attr_reader :id, :start_date, :end_date

  def initialize(id, start_date, end_date)
    #add rooms_needed to def initialize
    # cost?
    # rooms_needed
    @id = id 
    @start_date = start_date
    @end_date = end_date
    #add itself to reservation list

  end
  #reserves room by selecting first available room for now

end


#find reservations for a specific date
#I can get total cost for reservation
