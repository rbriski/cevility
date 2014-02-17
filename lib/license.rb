require 'active_support/core_ext'

class License < Struct.new(:number)
  def initialize(*args)
    options = args.extract_options!

    self.number = options[:number].upcase
  end

  def to_s
    self.number
  end
end