require 'spec_helper'

describe 'QRCode' do
  context '#slug' do
    it 'should return a random 4 character slug' do
      expect(QRCode.random_slug.size).to eq 4
    end

    it 'should pick another while the previous already exists' do
      qr = FactoryGirl.create(:qr_code)
      expect(QRCode).to receive(:random_slug).once.and_return(qr.slug)
      expect(QRCode).to receive(:random_slug).once.and_return('something_else')

      QRCode.create_random
    end

    it 'should know if its not linked to a license' do
      qr = FactoryGirl.create(:qr_code)
      expect(qr.linked?).to be false
    end

    it 'should know if its linked' do
      l = FactoryGirl.create(:license)
      qr = l.add_qr_code

      expect(qr.linked?).to be true
    end

    it 'should know its license' do
      l = FactoryGirl.create(:license)
      qr = l.add_qr_code

      expect(qr.license).to eq l
    end
  end
end