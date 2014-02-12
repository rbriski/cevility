require 'rubygems'
require 'bundler'

Bundler.require

DB = Sequel.connect(ENV.fetch("DATABASE_URL"))

$: << File.dirname(__FILE__) + "/lib"
require 'status'

require './ev'
run EV