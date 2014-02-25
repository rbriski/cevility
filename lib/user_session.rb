require 'active_support/core_ext'
require 'koala'
require 'pp'

# {"provider"=>"facebook",
#  "uid"=>"545775971",
#  "info"=>
#   {"nickname"=>"bob.briski",
#    "email"=>"rbriski@gmail.com",
#    "name"=>"Bob Briski",
#    "first_name"=>"Bob",
#    "last_name"=>"Briski",
#    "image"=>"http://graph.facebook.com/545775971/picture",
#    "urls"=>{"Facebook"=>"https://www.facebook.com/bob.briski"},
#    "verified"=>true},
#  "credentials"=>
#   {"token"=>
#     "CAAKgW5uUc2UBALaDv21xIgtBktsoZCuBEEr1H62GUlZAbvNPFCKvmzmlseg3DFrGUmujT22yqMLJt49HnSkY6hKDR4qov7lZCWawcsZAuZCH5dHjtC4OncZC6PhdhZAc1mZBXZAiO6ZAAUiloeTZBEFZByMWgsd8SVLCnCVgUqSkPMAvd9V7F9O5r1J3W1O4mWGMXbkZD",
#    "expires_at"=>1398402948,
#    "expires"=>true},
#  "extra"=>
#   {"raw_info"=>
#     {"id"=>"545775971",
#      "name"=>"Bob Briski",
#      "first_name"=>"Bob",
#      "last_name"=>"Briski",
#      "link"=>"https://www.facebook.com/bob.briski",
#      "gender"=>"male",
#      "email"=>"rbriski@gmail.com",
#      "timezone"=>-8,
#      "locale"=>"en_US",
#      "verified"=>true,
#      "updated_time"=>"2014-02-24T05:15:28+0000",
#      "username"=>"bob.briski"}}}
class UserSession
  def initialize(response)
    @auth = response['omniauth.auth']
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
