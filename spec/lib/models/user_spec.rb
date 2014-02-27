require 'spec_helper'
require 'active_support/core_ext'

h = {
  "provider"=>"facebook",
  "uid"=>"545555271",
  "info"=>
  {
    "nickname"=>"bob.coin",
    "email"=>"blah@gmail.com",
    "name"=>"Bob Coin",
    "first_name"=>"Bob",
    "last_name"=>"Coin",
    "image"=>"http://graph.facebook.com/545555271/picture",
    "urls"=>{
      "Facebook"=>"https://www.facebook.com/bob.coin"
    },
    "verified"=>true
  },
  "credentials"=>
  {
    "token"=>
    "CAAKgW5uUc2UBALaDv21xIgtBBBsoZCuBEErsd62GUlZAbvNPFCKvmzmlseg3DFrGUmujT22yqMLJt49HnSkY6hKDR4qov7lZCWawcsZAuZCH5dHjtC4OncZC6PhdhZAc1mZBXZAiO6ZAAUiloeTZBEFZByMWgsd8SVLCnCVgUqSkPMAvd9V7F9O5r1J3W1O4mWGMXbkZD",
    "expires_at"=>1398402948,
    "expires"=>true
  },
  "extra"=>
  {
    "raw_info"=>
    {
      "id"=>"545555271",
      "name"=>"Bob Coin",
      "first_name"=>"Bob",
      "last_name"=>"Coin",
      "link"=>"https://www.facebook.com/bob.coin",
      "gender"=>"male",
      "email"=>"blah@gmail.com",
      "timezone"=>-8,
      "locale"=>"en_US",
      "verified"=>true,
      "updated_time"=>"2014-02-24T05:15:28+0000",
      "username"=>"bob.coin"
    }
  }
}
FB_AUTH = Hashie::Mash.new h

describe 'User' do
  before(:each) do
    @user = User.new
  end

  # it 'should know when it expires' do
  #   @user.oauth_expires_at.should_not be_blank
  # end

  it 'should know if its expired' do
    @user.should_receive(:expires_at).and_return(Time.now.ago(5.hours))
    @user.expired?.should be_true
  end

  it 'should know if its not expired' do
    @user.should_receive(:expires_at).and_return(Time.now.since(5.hours))
    @user.expired?.should be_false
  end
end