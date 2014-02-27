require "sinatra/json"
require 'pp'

class EV < Sinatra::Base
  get '/auth/:provider/callback' do
    user = User.from_omniauth request.env['omniauth.auth']
    session['user_id'] = user.id

    redirect request.referrer
  end

  get '/auth/failure' do
    redirect '/'
  end

  get '/session/destroy' do
    session['user_id'] = nil

    redirect '/'
  end

  get '/session/revoke' do
    current_user.revoke_all_permissions

    redirect request.referrer
  end
end