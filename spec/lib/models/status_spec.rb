require 'spec_helper'

describe 'Status' do
  it 'should load status model' do
    s = Status.new
    s.class.name.should == 'Status'
  end
end