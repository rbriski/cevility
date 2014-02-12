class Status < Sequel::Model
  set_dataset DB[:statuses]

  class << self
    def find_or_create_by_license(number)
      license = self[:license => number]
      if license.blank?
        puts "setting to #{license}"
        license = self.create { | s | s.license = number }
      end
      license
    end
  end
end