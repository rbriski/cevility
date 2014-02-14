require_relative './acceptance_helper.rb'

describe "the index", :type => :feature do
  it "signs me in" do
    visit '/'
    expect(page).to have_content 'Welcome!'
  end
end