require_relative './acceptance_helper.rb'

describe "setting statuses", :type => :feature do
  it "says when a license number doesnt exist" do
    visit '/'
    fill_in 'license', :with => '4df33'
    click_button 'Check Status'

    expect(page).to have_content 'There is no record of that license'
  end

  it "defaults to an OK status" do
    visit '/'
    fill_in 'license', :with => '4df33'
    click_button 'This is my car'

    expect(page).to have_checked_field "OK"
  end

  it "can set and check a status" do
    visit '/'
    fill_in 'license', :with => '4df33'
    click_button 'This is my car'

    choose 'CHARGING'
    click_button 'Set Status'

    expect(page).to have_content "Status for 4DF33 is currently charging"
  end

  it 'can reset status' do
    visit '/'
    fill_in 'license', :with => '4df33'
    click_button 'This is my car'

    choose 'CHARGING'
    click_button 'Set Status'

    visit '/'
    fill_in 'license', :with => '4df33'
    click_button 'This is my car'

    choose 'OK'
    click_button 'Set Status'

    expect(page).to have_content "Status for 4DF33 is ok to unplug"
  end
end