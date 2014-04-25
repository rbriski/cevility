require 'sinatra/base'
require 'sinatra/content_for'
require 'active_support/all'

SCOPE = 'email'
class EV < Sinatra::Base
  set :logging, true
  set :erb, :trim => '-'
  use Rack::Flash, :sweep => true

  use OmniAuth::Builder do
    provider :facebook, ENV.fetch('FB_APP_ID'), ENV.fetch('FB_SECRET'), :scope => SCOPE
  end

  use Rack::MethodOverride

  helpers Sinatra::ContentFor
  helpers do
    def flash_types
      [:success, :info, :warning, :danger]
    end

    def current_user
      @current_user ||= User[:id => session['user_id']] if session['user_id']
    end
  end

  # For using form helper-type parameter names
  # E.g. license[number], user[name]
  before do
    new_params = {}
    params.each_pair do |full_key, value|
      this_param = new_params
      split_keys = full_key.split(/\]\[|\]|\[/)
      split_keys.each_index do |index|
        break if split_keys.length == index + 1
        this_param[split_keys[index]] ||= {}
        this_param = this_param[split_keys[index]]
     end
     this_param[split_keys.last] = value
    end
    request.params.replace new_params
  end

  get '/' do
    erb :index
  end

  get '/privacy' do
    erb :privacy
  end

  not_found do
    status 404
    erb :not_found
  end
end

require_relative 'routes/init'