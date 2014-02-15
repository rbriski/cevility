require 'rubygems'
require 'bundler'

Bundler.require

ENV['HONEYBADGER_API_KEY'] ||= ''
ENV['DATABASE_URL'] ||= 'postgres://localhost/ev'
DB ||= Sequel.connect(ENV.fetch("DATABASE_URL"))

$stdout.sync = true

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

# Configure the API key
Honeybadger.configure do |config|
  config.api_key = ENV.fetch('HONEYBADGER_API_KEY')
end

use Honeybadger::Rack

require './ev'
run EV