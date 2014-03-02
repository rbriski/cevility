require 'spec_helper'

describe 'Status' do
  it 'should load status model' do
    s = Status.new
    expect(s.class.name).to eq('Status')
  end
end