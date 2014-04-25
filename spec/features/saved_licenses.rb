require_relative './acceptance_helper.rb'

describe "saved licenses", :type => :feature, :js => true do
  let(:number) do
    'BWN2343PN'
  end

  before(:all) do
    Capybara.reset_sessions!
  end

  it 'can add licenses to your account' do
    visit '/'
    complete_facebook_dialogues_on_click('#connect', 'schmob_jksvheu_schmriski@tfbnw.net', 'schmob')

    sleep 1
    visit '/account'
    click_on 'Add one'

    fill_in 'assign_number', :with => 'BOB'
    click_on 'Assign'

    expect(page).to have_content('BOB')
  end

  it 'saves a license' do
    visit '/'
    # complete_facebook_dialogues_on_click('#connect', 'schmob_jksvheu_schmriski@tfbnw.net', 'schmob')

    sleep 1
    visit "/set/#{number}"
    find('#assign_license').click

    visit '/'
    expect(page).to have_content(number)
  end

end