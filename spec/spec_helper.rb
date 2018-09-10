require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require "minitest/pride"
require "pry"
require "awesome_print"
require "date"
require "csv"

TEST_RESERVATION_FILENAME = "support/test_reservation_data.csv"

# Add lib files here (require_relative "../")
require_relative "../hotbook.rb"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
