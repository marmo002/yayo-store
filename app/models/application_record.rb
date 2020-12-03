class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  MAX_LOGIN_ATTEMPTS = 3

  PASSWORD_FORMAT = /\A
    [a-zA-Z\d\s]+\z # No special characters
  /x

  def generate_random_code
    SecureRandom.base64(24)
  end
end
