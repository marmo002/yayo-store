class Type < ApplicationRecord
  validates :name,     presence: { message: "Nombre no puede estar vacio" }
  validates :name,     uniqueness: { case_sensitive: false, message: "Tipo de producto ya existe!" }

  def name=(name)
    write_attribute(:name, name.strip.downcase.titleize)
  end


end
