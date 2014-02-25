require 'user_session'

FB_AUTH = {
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

describe 'UserSession' do
  before(:each) do
    @us = UserSession.new
    @auth = FB_AUTH.clone
  end

  it 'should default to unauthorized' do
    @us.authorized?.should be_false
  end

  it 'should know when an auth has been successful' do
    @us.connect 'omniauth.auth' => @auth
    @us.authorized?.should be_true
  end

  it 'should know when an auth has failed' do
    @auth.delete('uid')
    @us.connect 'omniauth.auth' => @auth
    @us.authorized?.should be_false
  end

  it 'should know when it expires' do
    @us.connect 'omniauth.auth' => @auth
    @us.expires_at.should == @auth['credentials']['expires_at']
  end

  it 'should return nil if expires_at is not set' do
    @us.expires_at.should be_nil
  end

  it 'should be expired if there is no expired_at time' do
    @us.expired?.should be_true
  end

  it 'should know if its expired' do
    @auth['credentials']['expires_at'] = Time.now.ago(5.hours).to_i
    @us.connect 'omniauth.auth' => @auth
    @us.expired?.should be_true
  end

  it 'should know if its not expired' do
    @auth['credentials']['expires_at'] = Time.now.since(5.hours).to_i
    @us.connect 'omniauth.auth' => @auth
    @us.expired?.should be_false
  end

  it 'should not reauthorized if never logged in' do
    @us.reauthorize?.should be_false
  end

  it 'should not reauthorize if not expired' do
    @us.connect 'omniauth.auth' => @auth
    @us.should_receive(:expired?).and_return(false)

    @us.reauthorize?.should be_false
  end

  it 'should be true only if auth exists and the session has expired' do
    @us.connect 'omniauth.auth' => @auth
    @us.should_receive(:expired?).and_return(true)

    @us.reauthorize?.should be_true
  end
end