class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  MAX_LOGIN_ATTEMPTS = 3

  PASSWORD_FORMAT = /\A
    (?=.*[0-9]) # Must contain at least one number
    (?=.*[A-Z]) # Must contain an uppercase character
    (?=.*[a-z]) # Must contain a lowercase character
    (?!.*[^A-Za-z0-9]) # No special characters
  /x

  def generate_random_code
    SecureRandom.base64(24)
  end
end
