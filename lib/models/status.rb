class Status < Sequel::Model(:statuses)
  DEFAULT_STATUS = 'OK'

  plugin :timestamps, :update_on_create=>true
  many_to_one :license

  class << self
    def find_or_create_by_license(number)
      license = self[:license => number]
      if license.blank?
        puts "#{number} not found, creating."
        license = self.create { | s | s.license = number }
      end
      license
    end
  end

  def status
    s = super
    s ||= DEFAULT_STATUS
  end

  def to_s
    self.status
  end
end