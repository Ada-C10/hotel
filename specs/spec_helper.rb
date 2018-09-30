require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/date_range.rb'
require_relative '../lib/hotel_admin.rb'
