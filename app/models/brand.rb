class Brand < ApplicationRecord
  validates :name,     presence: { message: "Nombre no puede estar vacio" }
  validates :name,     uniqueness: { case_sensitive: false, message: "Marca ya existe!" }

  def name=(name)
    write_attribute(:name, name.strip.downcase.titleize)
  end

end
