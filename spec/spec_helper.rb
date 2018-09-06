# Add simplecov
require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/hell'

require 'pry'
require 'awesome_print'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/reservations_manager'
