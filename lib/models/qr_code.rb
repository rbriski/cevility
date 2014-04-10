class QRCode < Sequel::Model(:qr_codes)
  plugin :timestamps, :update => nil

  def self.random_slug
    SecureRandom.hex 2
  end

  def self.create_random
    qr = nil
    begin
      qr = self.create(:slug => self.random_slug)
    rescue Sequel::UniqueConstraintViolation => e
      retry
    end
    qr
  end

  def license
    return nil if self.license_id.nil?

    License[:id => self.license_id]
  end

  def linked?
    !!self.license
  end

  class Exception < StandardError; end
end