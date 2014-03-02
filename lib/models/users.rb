require 'koala'

class User < Sequel::Model(:users)
  plugin :timestamps
  one_to_many :licenses

  class << self
    def exchange_token(token)
      oauth = Koala::Facebook::OAuth.new(ENV["FB_APP_ID"], ENV["FB_SECRET"])
      oauth.exchange_access_token_info token
    end

    def from_omniauth(auth)
      primary_keys = auth.slice(:provider, :uid).to_h.symbolize_keys
      u = self.find_or_initialize_by_provider_and_uid(primary_keys).tap do | user |
        user.nickname         = auth.info.nickname
        user.name             = auth.info.name
        user.email            = auth.info.email
        user.first_name       = auth.info.first_name
        user.last_name        = auth.info.last_name
        user.locale           = auth.extra.raw_info.locale
        user.tz_offset        = auth.extra.raw_info.timezone

        exchanged_token_info  = User.exchange_token(auth.credentials.token)
        user.oauth_token      = exchanged_token_info['access_token']
        user.oauth_expires_at = Time.at(DateTime.now + exchanged_token_info['expires'].to_i.seconds)

        user.image_url        = User.get_picture(user.oauth_token)

        user.save
      end
    end

    def get_picture(token)
      g = Koala::Facebook::API.new(token)
      g.get_picture '/me/picture', :type => 'square', :height => 28, :width => 28
    end

    def find_or_initialize_by_provider_and_uid(options)
      user = self[options]
      if user.blank?
        puts "#{options[:uid]} not found for #{options[:provider]}, initializing..."
        user = self.new.tap { | u |
          u.provider = options[:provider]
          u.uid = options[:uid]
        }
      end
      user
    end
  end

  def expired?
    Time.now > expires_at
  end
end