require 'time'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'awesome_print'
require 'simplecov'
SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/rooms'
require_relative '../lib/admin'
require_relative '../lib/reservations'
require_relative '../lib/blocked_rooms'
require_relative '../lib/avail_rooms'
require_relative '../lib/cost'
