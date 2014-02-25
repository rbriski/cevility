require "sinatra/json"

class EV < Sinatra::Base
  def redirect_back
    back_to = session.delete('back_to')
    back_to ||= '/'
    redirect back_to
  end

  get '/session/create' do
    session['back_to'] = request.referrer

    redirect '/auth/facebook'
  end

  get '/auth/:provider/callback' do
    session['current_user'] = UserSession.new request.env

    200
  end

  get '/auth/failure' do
    session['auth_denied'] = true

    200
  end

  get '/session/destroy' do
    session['current_user'] = nil
    200
  end

  get '/session/revoke' do
    session['current_user'].revoke_all_permissions

    redirect request.referrer
  end
end