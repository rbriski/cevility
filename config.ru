require 'rubygems'
require 'bundler'

Bundler.require

require 'rack/session/moneta'

# Set up sequel DB
DB ||= Sequel.connect(ENV.fetch("DATABASE_URL"))

# Loggin stream
$stdout.sync = true

# Include all files from lib
Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

# Error loggin
Honeybadger.configure do |config|
  config.api_key = ENV.fetch('HONEYBADGER_API_KEY')
end
use Honeybadger::Rack


# Set up redis
REDIS = Redis.new(:url => ENV.fetch('REDISCLOUD_URL'))

# Set up stored sessions
use Rack::Session::Moneta,
  :store => Moneta.new(:Redis, :backend => REDIS, :expires => false)

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