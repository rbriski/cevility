require 'active_support/core_ext'

class License < Sequel::Model(:licenses)
  many_to_one :user

  def number=(number)
    super(number.upcase)
  end

  def to_s
    self.number
  end
end