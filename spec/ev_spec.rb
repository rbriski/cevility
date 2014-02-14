require_relative './spec_helper'

describe 'Cevility' do
  it 'should load status model' do
    s = Status.new
    s.class.name.should == 'Status'
  end
end