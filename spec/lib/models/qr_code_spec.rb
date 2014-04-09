require 'spec_helper'

describe 'QRCode' do
  context '#slug' do
    it 'should return a random 4 character slug' do
      expect(QRCode.random.size).to eq 4
    end

    it 'should pick another while the previous already exists' do
      expect(QRCode).to receive(:where).once.and_return(['something'])
      expect(QRCode).to receive(:where).once.and_return([])

      QRCode.random
    end
  end
end