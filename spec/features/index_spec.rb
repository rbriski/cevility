require_relative './acceptance_helper.rb'

describe "the index", :type => :feature do
  it "loads the index" do
    visit '/'
    expect(page).to have_content 'Welcome!'
  end

  it 'does not accept a blank license number' do
    visit '/status/'
    page.status_code.should == 404
  end
end