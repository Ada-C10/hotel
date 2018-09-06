require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require "minitest/pride"
require "pry"
require "awesome_print"

# Add lib files here (require_relative "../")
require_relative "../lib/book.rb"
require_relative "../lib/cost.rb"
require_relative "../lib/hotel.rb"
require_relative "../lib/loader.rb"
require_relative "../lib/reservation.rb"


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
