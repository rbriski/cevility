require 'spec_helper'

describe 'Status' do
  it 'should load status model' do
    s = Status.new
    expect(s.class.name).to eq('Status')
  end

  it 'should require a license id' do
    s = Status.new
    expect{s.save}.to raise_error(Sequel::NotNullConstraintViolation)
  end

  it 'should be able to find its license record' do
    l = FactoryGirl.create(:license)

    s = Status.new :license_id => l.id
    expect(s.license.number).to eq(l.number)
  end

  it 'should to_s to the status' do
    s = Status.new :status => "OK"
    expect("#{s}").to eq("OK")
  end

  it 'should have updated time after save' do
    l = FactoryGirl.create(:license)
    s = FactoryGirl.build(:status)
    l.status = s
    l.save

    old = s.updated_at
    s.description = "new status"
    s.save

    expect(s.updated_at).to be > old
  end
end