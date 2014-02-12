require 'rubygems'
require 'bundler'

Bundler.require

DB = Sequel.connect('postgres://localhost/ev')

$: << File.dirname(__FILE__) + "/lib"
require 'status'

require './ev'
run EV