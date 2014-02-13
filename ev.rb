require 'sinatra/base'
require 'active_support/all'

class EV < Sinatra::Base
  set :sessions, true
  use Rack::Flash, :sweep => true

  helpers do
    def flash_types
      [:success, :info, :warning, :danger]
    end
  end

  get '/' do
    erb :index
  end

  post '/' do
    puts params
    if params[:do] == 'Check Status'
      redirect "/status/#{params[:license]}"
    else
      redirect "/set/#{params[:license]}"
    end
  end

  get '/status/:license' do
    @status = Status[:license => params[:license].upcase]
    if @status.blank?
      flash[:danger] = "There is no record of that license [#{params[:license]}]"
      redirect '/'
    else
      erb :check_status
    end
  end

  get '/set/:license' do
    @license = params[:license]
    erb :set_license
  end

  post '/set/:license' do
    @license = params[:license]

    status = Status.find_or_create_by_license(@license)
    status.status = params[:status]
    status.description = params[:description]
    status.save

    redirect "/status/#{@license}"
  end

  get '/privacy' do
    erb :privacy
  end
end