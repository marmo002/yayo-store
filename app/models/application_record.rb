class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  PASSWORD_FORMAT = /\A
    (?=.*[0-9]) # Must contain at least one number
    (?=.*[A-Z]) # Must contain an uppercase character
    (?=.*[a-z]) # Must contain a lowercase character
    (?!.*[^A-Za-z0-9]) # No special characters
  /x
end
