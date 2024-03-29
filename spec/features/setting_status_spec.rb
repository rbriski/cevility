require_relative './acceptance_helper.rb'

describe "setting statuses", :type => :feature do
  it "says when a license number doesnt exist" do
    visit '/'
    fill_in 'check_status', :with => '4df33'
    click_button 'Check Status'

    expect(page).to have_content 'There is no record of that license'
  end

  it "defaults to an OK status" do
    visit '/'
    fill_in 'set_status', :with => '4df33'
    click_button 'Set Status'

    expect(page).to have_checked_field "OK"
  end

  it "can set and check a status" do
    visit '/'
    fill_in 'set_status', :with => '4df33'
    click_button 'Set Status'

    choose 'CHARGING'
    click_button 'Set Status'

    expect(page).to have_content "Status for 4DF33 is currently charging"
  end

  it 'can reset status' do
    visit '/'
    fill_in 'set_status', :with => '4df33'
    click_button 'Set Status'

    choose 'CHARGING'
    click_button 'Set Status'

    visit '/'
    fill_in 'set_status', :with => '4df33'
    click_button 'Set Status'

    choose 'OK'
    click_button 'Set Status'

    expect(page).to have_content "Status for 4DF33 is ok to unplug"
  end

  it 'keeps the status description when re-editing' do
    visit '/'
    fill_in 'set_status', :with => '4df33'
    click_button 'Set Status'

    choose 'CHARGING'
    fill_in 'status[description]', :with => 'I just set this'
    click_button 'Set Status'

    visit '/'
    fill_in 'set_status', :with => '4df33'
    click_button 'Set Status'

    expect(find_field('status[description]').value).to eq 'I just set this'
  end

  it 'keeps the status when re-editing' do
    visit '/'
    fill_in 'set_status', :with => '4df33'
    click_button 'Set Status'

    choose 'CHARGING'
    fill_in 'status[description]', :with => 'I just set this'
    click_button 'Set Status'

    visit '/'
    fill_in 'set_status', :with => '4df33'
    click_button 'Set Status'

    expect(find_field('status_charging')).to be_checked
    expect(find_field('status_ok')).not_to be_checked
  end
end