require 'spec_helper'

describe 'License' do
  before(:each) do
    @license = License.new :number => '23sfdf23'
  end

  it 'should upcase all numbers' do
    @license.number.should == '23SFDF23'
  end

  it 'should use the number in to_s' do
    "#{@license}".should == '23SFDF23'
  end
end