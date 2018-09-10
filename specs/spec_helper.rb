require 'simplecov'
SimpleCov.start

require 'date'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'awesome_print'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/reservation'
require_relative '../lib/reservation_tracker'
require_relative '../lib/date_range'
require_relative '../lib/block'
