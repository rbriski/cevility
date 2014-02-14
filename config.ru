require 'rubygems'
require 'bundler'

Bundler.require

ENV['DATABASE_URL'] ||= 'postgres://localhost/ev'
DB ||= Sequel.connect(ENV.fetch("DATABASE_URL"))

$stdout.sync = true

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

require './ev'
run EV