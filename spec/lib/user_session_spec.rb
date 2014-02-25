require 'user_session'

describe 'UserSession' do
  it 'should default to unauthorized' do
    us = UserSession.new
    us.authorized?.should be_false
  end

  it 'should know when an auth has been successful' do
    us = UserSession.new :code => 'blah'
    us.authorized?.should be_true
  end

  it 'should know when an auth has failed' do
    us = UserSession.new :error => 'access_denied', :error_code => 200, :error_description => 'Permissions error', :error_reason => 'user_denied'
    us.denied?.should be_true
  end
end