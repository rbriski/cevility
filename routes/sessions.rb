require "sinatra/json"

class EV < Sinatra::Base
  get '/auth/:provider/callback' do
    current_user.connect request.env

    json result: 'success'
  end

  get '/auth/failure' do
    session['auth_denied'] = true

    json result: 'failure'
  end

  get '/session/destroy' do
    session['current_user'] = nil

    json result: 'success'
  end

  get '/session/revoke' do
    current_user.revoke_all_permissions

    redirect request.referrer
  end
end