require 'pry'
class Name
  attr_reader :name

  def initialize (name)
    @name = name
  end

  def say_my_name
    @name
  end

end
