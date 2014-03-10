require 'spec_helper'

describe 'License' do
  before(:each) do
    @license = License.new :number => '23sfdf23'
  end

  it 'should upcase all numbers' do
    expect(@license.number).to eq('23SFDF23')
  end

  it 'should use the number in to_s' do
    expect("#{@license}").to eq('23SFDF23')
  end

  context 'validations' do
    it 'should fail on blank number' do
      l = License.new
      expect{l.save}.to raise_error(Sequel::NotNullConstraintViolation)
    end
  end

  context 'status' do
    before(:each) do
      @status = FactoryGirl.build(:status)
    end

    it 'should default to default status' do
      l = License.new
      expect(l.status.status).to eq(Status::DEFAULT_STATUS)
    end

    it 'should default to blank description' do
      l = License.new
      expect(l.status.description).to be_blank
    end

    it 'should accept a status' do
      l = FactoryGirl.create(:license)
      l.status = @status

      expect(l.status.status).to eq(@status.status)
    end
  end
end