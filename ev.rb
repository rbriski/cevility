require 'sinatra/base'
require 'active_support/all'

class EV < Sinatra::Base
  set :sessions, true
  set :logging, true
  use Rack::Flash, :sweep => true

  helpers do
    def flash_types
      [:success, :info, :warning, :danger]
    end

    def statuses(status)
      puts status
      s = {
        'OK' => 'ok to unplug',
        'CHARGING' => 'currently charging',
        'WAITING' => 'waiting for a charge'
      }
      s[status]
    end

    def fb_auth
      @oauth ||= Koala::Facebook::OAuth.new(739265266086757, 'd5d7a0ed452adc10d0550fe7eaf598ef', url('/fb_auth'))
      @oauth
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

  post '/' do
    license = License.new :number => params[:license]

    if params[:do] == 'Check Status'
      redirect "/status/#{license}"
    else
      redirect "/set/#{license}"
    end
  end

  get '/status/:license' do
    license = License.new :number => params[:license]

    @status = Status[:license => license.number]
    if @status.blank?
      flash[:danger] = "There is no record of that license [#{license}]"
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
    @license = License.new :number => params[:license]

    status = Status.find_or_create_by_license(@license.number)
    status.status = @status[:name]
    status.description = @status[:description]
    status.save

    redirect "/status/#{@license}"
  end

  get '/qr/:code' do
    redirect '/status/7BWN656'
  end

  get '/privacy' do
    erb :privacy
  end

  get '/qr/:code' do
    @qr = RQRCode::QRCode.new( "http://www.cevility.com/qr/#{params[:code]}", :size => 4, :level => :h )
    erb :sign, :layout => false
  end

  get '/session/new' do
    session['referrer'] = request.referrer
    session['oauth'] = Koala::Facebook::OAuth.new(ENV.fetch('FB_APP_ID'), ENV.fetch('FB_SECRET'), url('/session/create'))
    redirect session['oauth'].url_for_oauth_code(:scope => 'email')
  end

  get '/session/create' do
    if params.has_key?('code')
      session['access_token'] = session['oauth'].get_access_token(params[:code])
    else
      session['access_denied'] = true
    end

    back_to = session.delete('referrer')
    back_to ||= '/'
    redirect back_to
  end

  get '/session/destroy' do
    session['graph'] = Koala::Facebook::API.new(session['access_token'])
    profile = session['graph'].get_object("me")

    puts session['graph'].delete_object("/#{profile['id']}/permissions")
  end

  not_found do
    status 404
    erb :not_found
  end
end