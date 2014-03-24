require_relative './acceptance_helper.rb'

describe "saved licenses", :type => :feature, :js => true do
  let(:number) do
    'BWN2343PN'
  end

  before(:all) do
    Capybara.reset_sessions!
  end

  it 'saves a license' do
    visit "/set/#{number}"
    complete_facebook_dialogues_on_click('#connect', 'schmob_jksvheu_schmriski@tfbnw.net', 'schmob')

    find('#assign_license').click

    expect(page).to have_content('is now assigned to you')
  end

  it 'shows a license on the index' do
    visit '/'
    expect(page).to have_content(number)
  end

end