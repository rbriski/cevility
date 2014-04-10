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

  context 'creation' do
    it 'should create a new license on failed hit' do
      l = License.find_or_create_by_number('2343')
      expect(l.slug.blank?).to be true
    end

    it 'should find an existing license' do
      old_l = FactoryGirl.create(:license)
      l = License.find_or_create_by_number(old_l.number)
      expect(l.slug).to eq old_l.slug
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

    it 'should be able to change status' do
      s = Status.new(:status => 'OK')
      s2 = Status.new(:status => 'CHARGING')

      l = FactoryGirl.create(:license)
      l.status = s
      l.save

      l.status = s2
    end

  context 'qr_code' do
    it 'should add a new qr_code if none is passed' do
      qr = instance_double("QRCode",
        :license_id => nil,
        :license_id= => '',
        :save => ''
      )
      l = FactoryGirl.create(:license)
      expect(QRCode).to receive(:create_random).once.and_return(qr)

      expect(l.add_qr_code).to eq qr
    end

    it 'should associate qr_code if passed' do
      qr = FactoryGirl.create(:qr_code)
      l = FactoryGirl.create(:license)

      expect(QRCode).not_to receive(:create_random)
      q = l.add_qr_code(qr)
      expect(q.license_id).to eq l.id
    end

    it 'should get the most recent qr code' do
      l = FactoryGirl.create(:license)
      qr_old = FactoryGirl.create(:qr_code, :slug => 'old',
        :created_at => Time.now.ago(1.day),
        :license_id => l.id
      )
      qr_new = FactoryGirl.create(:qr_code, :slug => 'new',
        :created_at => Time.now.ago(1.hour),
        :license_id => l.id
      )

      expect(l.qr_code).to eq qr_new
    end

    it 'should return nil if there is no qr_code' do
      l = FactoryGirl.create(:license)
      expect(l.qr_code).to be_nil
    end

    it 'should fail to add if the qr code already is associated' do
      qr = instance_double("QRCode", :license_id => 2)
      l = FactoryGirl.create(:license)

      expect { l.add_qr_code(qr) }.to raise_error(QRCode::Exception)
    end
  end

  end
end