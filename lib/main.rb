require 'colorize'

require_relative 'date_range'
require_relative 'room'
require_relative 'reservation'
require_relative 'block'
require_relative 'reservation_tracker'
require_relative 'block'


def main(reservation_tracker)
  welcome
  reservation_details(reservation_tracker)
  continue?(reservation_tracker)
end

def print_reservations_list_by_date(reservation_tracker)
  list = reservation_tracker.print_reservations_list_by_date
  puts list
end

def print_planet_summary(user_input, solar_system)
  found_planet = solar_system.find_planet_by_name(user_input)
  puts found_planet.summary
end

def correct_planet_entry?(solar_system)
  user_input = get_user_input
  until planet_options(solar_system).include?(user_input.downcase)
    print "\nInvalid entry. Try again.\n"
    user_input = get_user_input
  end
  return user_input
end

def planet_options(solar_system)
  planet_options = solar_system.planets.map do |planet|
    planet.name.downcase
  end
  return planet_options
end

def goodbye
  puts "\n~*~***~GOODBYE!~***~*~".yellow
  exit
end

def welcome
  puts "\n~*~*~*~~~**Welcome to The Universe Info Page!**~~~*~*~*~\n".magenta
end

def add_planets_to_ss(solar_system)
  earth = Planet.new('Earth', 'blue-green', 5.972e24, 1.496e8, 'Only planet known to support life')

  jupiter = Planet.new('Jupiter', 'red', 1.898e27, 7.78e6, 'That red eye tho')

  make_believe = Planet.new('Make Believe', 'turquoise', 3.2e25, 4.21e7, 'I just made this planet up!')

  solar_system.add_planet(earth)
  solar_system.add_planet(jupiter)
  solar_system.add_planet(make_believe)
end

solar_system = SolarSystem.new('Sol')
add_planets_to_ss(solar_system)
main(solar_system)
