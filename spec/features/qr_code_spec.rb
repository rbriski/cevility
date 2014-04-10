require_relative './acceptance_helper.rb'

describe "qr code page", :type => :feature do
  it "load an existing qr code" do
    qr = QRCode.create_random

    visit "/qr/#{qr.slug}/show"
    expect(page).to have_content 'Check the status of my charge'
  end

  it 'should not load a qr code that doesnt exist' do
    visit '/qr/not_a_slug/show'
    expect(page.status_code).to eq(404)
  end

  it 'can redirect a linked qr code the status' do
    l = FactoryGirl.create(:license)
    l.add_qr_code

    visit '/'
    fill_in 'set_status', :with => l.number
    click_on 'Set Status'

    fill_in 'status[description]',
      :with => "Contact me a 8675309 for questions."
    click_on 'Set Status'

    visit "/qr/#{l.qr_code.slug}"
    expect(page).to have_content "Contact me a 8675309 for questions"
  end

  it 'can redirect an unlinked qr code to the beginning of the workflow' do
    FactoryGirl.create(:qr_code, :slug => 'is_not_linked')

    visit "/qr/is_not_linked"
    expect(page).to have_content "Welcome to Cevility!"
  end

  it 'should 404 on a qr code does not exist' do
    visit "/qr/does_not_exist"
    expect(page.status_code).to eq(404)
  end

  it 'should associate a qr code with a license' do
    qr = QRCode.create_random

    visit "/qr/#{qr.slug}"
    fill_in 'license', :with => '3DRD233'
    click_on 'Set Your Status'

    fill_in 'status[description]',
      :with => "Contact me a 8675309 for questions."
    click_on 'Set Status'

    visit "/qr/#{qr.slug}"
    expect(page).to have_content "3DRD233"
  end
end