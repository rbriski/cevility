require 'sinatra/base'
require 'sinatra/content_for'
require 'active_support/all'

SCOPE = 'email'
class EV < Sinatra::Base
  set :logging, true
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

    def statuses(status)
      s = {
        'OK' => 'ok to unplug',
        'CHARGING' => 'currently charging',
        'WAITING' => 'waiting for a charge'
      }
      s[status]
    end
  end

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

  post '/status/check' do
    license = License.new :number => params[:license]
    redirect "/status/#{license}"
  end

  post '/status/set' do
    license = License.new :number => params[:license]
    redirect "/set/#{license}"
  end

  get '/status/:license' do
    @license = License[:number => params[:license]]

    if @license.blank?
      flash[:danger] = "There is no record of that license [#{params[:license]}]"
      redirect '/'
    else
      erb :check_status
    end
  end

  get '/set/:license' do
    @license = License.new :number => params[:license]
    erb :set_license
  end

  post '/set/:license' do
    @status = params[:status]
    @license = License.find_or_create_by_number(params[:license])

    @license.status = Status.new(@status)
    @license.save

    redirect "/status/#{@license}"
  end

  get '/privacy' do
    erb :privacy
  end

  post '/user/assign/:number' do
    @license = License.find_or_create_by_number(params[:number])
    current_user.add_license @license
    current_user.save

    erb :'shared/login_license_assignment', :layout => false
  end

  not_found do
    status 404
    erb :not_found
  end
end

require_relative 'routes/init'