require 'spec_helper'

require 'capybara/rspec'
require 'rack_session_access'
require 'rack_session_access/capybara'

set :run, false
set :raise_errors, true
set :logging, false

def app
  puts ENV['DATABASE_URL']
  Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__)).first
end

Capybara.app =  app