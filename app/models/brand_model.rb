class BrandModel < ApplicationRecord
  belongs_to :brand

  validates :name,     presence: { message: "Nombre no puede estar vacio" }

  def name=(name)
    write_attribute(:name, name.strip.downcase.titleize)
  end

end
