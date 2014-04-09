class QRCode < Sequel::Model(:qr_codes)
  def self.random
    slug = nil
    begin
      slug = SecureRandom.hex 2
    end while self.where(:slug => slug).count > 0
    slug
  end
end