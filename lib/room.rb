module Hotel
  class Room
    attr_reader :status

    def initialize(status = :AVAILABLE)
      @status = status
      validate_status
    end


    def validate_status
      status_options = [:AVAILABLE, :UNAVAILABLE]

      raise ArgumentError.new("You must enter a valid status.") unless status_options.include?(status)
    end



  end
end
