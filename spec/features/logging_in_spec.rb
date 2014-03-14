require_relative './acceptance_helper.rb'
require 'hashie'

describe "logging in", :type => :feature, :js => true do
  let(:user) do
    u = Hashie::Mash.new
    u.email = 'schmob_jksvheu_schmriski@tfbnw.net'
    u.password = 'schmob'
  end

  it 'removes the facebook button' do
    visit '/set/4df33'
    complete_facebook_dialogues_on_click('#connect', 'schmob_jksvheu_schmriski@tfbnw.net', 'schmob')
    expect(page).not_to have_css('#connect')
  end
end