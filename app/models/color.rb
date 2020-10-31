class Color < ApplicationRecord
  validates :name,                  presence: { message: "Nombre no puede estar vacio" }
  validates :name, :hex,            uniqueness: { case_sensitive: false, message: "Marca ya existe!" }

  def name=(name)
    write_attribute(:name, name.strip.downcase.titleize)
  end

end
