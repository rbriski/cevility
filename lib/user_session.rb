require 'active_support/core_ext'
require 'koala'

require_relative 'core_ext/hash'

class UserSession
  def authorized?
    @auth and @auth.has_key? 'uid'
  end

  def connect(response)
    @auth = response['omniauth.auth']
  end

  def expired?
    return true if expires_at.nil?

    Time.now.to_i > expires_at
  end

  def expires_at
    @auth and @auth.dig('credentials', 'expires_at')
  end

  # We only want to reauthorized if the session has expired
  # and the user has previously logged in
  def reauthorize?
    @auth and expired?
  end

  def revoke_all_permissions
    graph.delete_object("/#{@auth['uid']}/permissions")
  end

  def graph
    Koala::Facebook::API.new(@auth['credentials']['token'])
  end

  def picture args
    graph.get_picture '/me/picture', :type => 'square', :height => 28, :width => 28
  end
end
