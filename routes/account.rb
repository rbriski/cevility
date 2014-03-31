require "sinatra/json"
require 'pp'

class EV < Sinatra::Base
  # Go to account if logged in
  # Otherwise, back to index
  get '/account' do
    if current_user
      erb :'account/show'
    else
      redirect '/'
    end
  end

  # Remove the license from the current account
  delete '/license/:id' do
    if current_user
      license = License[params[:id]]
      license.delete
    end

    erb :'account/show'
  end
end