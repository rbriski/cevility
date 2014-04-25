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
end