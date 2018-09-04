module Hotel
  class Room
    attr_reader :status, :id

    def initialize(id, status = :AVAILABLE)
      @id = id
      @status = status
      
      validate_id
      validate_status

    end


    def validate_status
      status_options = [:AVAILABLE, :UNAVAILABLE]

      raise ArgumentError.new("You must enter a valid status.") unless status_options.include?(status)
    end


    def validate_id
      id_options = [1..20]

      raise ArgumentError.new("you must enter a valid id.") unless id_options.include?(id)
    end


  end
end
