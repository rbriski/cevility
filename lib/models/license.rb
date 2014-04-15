require 'active_support/core_ext'

class License < Sequel::Model(:licenses)
  many_to_one :user
  one_to_one :status

  def self.find_or_create_by_number(number)
    self[:number => number] || self.create { | s | s.number = number }
  end

  def add_qr_code(qr_obj = QRCode.create_random)
    if qr_obj.license_id
      raise QRCode::Exception, "Can not reassign a QR Code."
    end

    qr_obj.license_id = self.id
    qr_obj.save
    qr_obj
  end

  def number=(number)
    super(number.upcase)
  end

  def qr_code
    QRCode.where(:license_id => self.id)
      .order_by(Sequel.desc(:created_at))
      .first
  end

  def to_s
    self.number
  end

  def status
    if not @status
      @status = Status[:license_id => self.id]
      @status ||= Status.new
    end
    @status
  end

  def status=(st)
    Status.where(:license_id => self.id).delete

    super
  end
end