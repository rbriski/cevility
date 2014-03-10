require 'active_support/core_ext'

class License < Sequel::Model(:licenses)
  many_to_one :user
  one_to_one :status

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
end