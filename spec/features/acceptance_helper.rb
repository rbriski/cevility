require 'spec_helper'

require 'capybara/rspec'
require 'rack_session_access'
require 'rack_session_access/capybara'

Dir[File.dirname(__FILE__) + '/../support/**/*.rb'].each {|file| require file }

set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |config|
  config.include FacebookMacros
end

def app
  Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__)).first
end

Capybara.default_wait_time = 10
Capybara.server_port = 9292
Capybara.app_host = 'http://cevility.dev:9292'
Capybara.app =  app
