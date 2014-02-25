require 'rubygems'
require 'bundler'

Bundler.require

DB ||= Sequel.connect(ENV.fetch("DATABASE_URL"))

$stdout.sync = true

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

# Configure the API key
Honeybadger.configure do |config|
  config.api_key = ENV.fetch('HONEYBADGER_API_KEY')
end

use Honeybadger::Rack

#fix for JSON gem/activesupport bug. More info: http://stackoverflow.com/questions/683989/how-do-you-deal-with-the-conflict-between-activesupportjson-and-the-json-gem
if defined?(ActiveSupport::JSON)
  [Object, Array, FalseClass, Float, Hash, Integer, NilClass, String, TrueClass].each do |klass|
    klass.class_eval do
      def to_json(*args)
        super(args)
      end
      def as_json(*args)
        super(args)
      end
    end
  end
end

require './ev'
run EV