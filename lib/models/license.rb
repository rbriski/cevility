require 'active_support/core_ext'

class License < Sequel::Model(:licenses)
  many_to_one :user
  one_to_one :status

  class << self
    def find_or_create_by_number(number)
      self[:number => number] || self.create { | s | s.number = number }
    end
  end

  def number=(number)
    super(number.upcase)
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
    current_status = Status[:license_id => self.id]
    current_status.delete if current_status

    super
  end
end