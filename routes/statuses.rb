class EV < Sinatra::Base
  helpers do
    def statuses(status)
      s = {
        'OK' => 'ok to unplug',
        'CHARGING' => 'currently charging',
        'WAITING' => 'waiting for a charge'
      }
      s[status]
    end
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
    @license = License.find_or_create_by_number(params[:license])

    erb :set_license
  end

  post '/set/:license' do
    @status = params[:status]
    @license = License.find_or_create_by_number(params[:license])

    @license.status = Status.new(@status)
    @license.save

    redirect "/status/#{@license}"
  end
end