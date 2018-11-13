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

# Add lib files here (require_relative "../")
require_relative "../hotbook.rb"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
