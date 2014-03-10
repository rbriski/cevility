require_relative './acceptance_helper.rb'

describe "logging in", :type => :feature do
  let(:user) do
    FactoryGirl.build(:user).save
  end

  # it 'removes the facebook button' do
  #   page.set_rack_session(:user_id => user.id)
  #   visit '/set/4df33'
  #   expect(page).not_to have_css('#connect')
  # end
end