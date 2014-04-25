require 'spec_helper'


require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'capybara/rspec/features'

require 'rack_session_access'
require 'rack_session_access/capybara'

Dir[File.dirname(__FILE__) + '/../support/**/*.rb'].each {|file| require file }

set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |config|
  config.order = 'default'

  config.include FacebookMacros

  config.include Capybara::DSL, :type => :feature
  config.include Capybara::RSpecMatchers, :type => :feature

  # A work-around to support accessing the current example that works in both
  # RSpec 2 and RSpec 3.
  fetch_current_example = RSpec.respond_to?(:current_example) ?
    proc { RSpec.current_example } : proc { |context| context.example }

  # The before and after blocks must run instantaneously, because Capybara
  # might not actually be used in all examples where it's included.
  config.after do
    if self.class.include?(Capybara::DSL)
      Capybara.use_default_driver
    end
  end
  config.before do
    if self.class.include?(Capybara::DSL)
      example = fetch_current_example.call(self)
      Capybara.current_driver = Capybara.javascript_driver if example.metadata[:js]
      Capybara.current_driver = example.metadata[:driver] if example.metadata[:driver]
    end
  end
end

def app
  Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__)).first
end

Capybara.default_wait_time = 10
Capybara.server_port = 9292
Capybara.app_host = 'http://cevility.dev:9292'
Capybara.app =  app
