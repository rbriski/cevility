class Status < Sequel::Model(:statuses)
  DEFAULT_STATUS = 'OK'

  plugin :timestamps, :update_on_create=>true
  many_to_one :license

  def status
    s = super
    s ||= DEFAULT_STATUS
  end

  def to_s
    self.status
  end
end