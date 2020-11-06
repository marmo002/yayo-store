class Size < ApplicationRecord
  has_many :color_sizes
  has_many :product_colors, through: :color_sizes

  validates :name,                  presence: { message: "Nombre no puede estar vacio" }
  validates :name,                  uniqueness: { case_sensitive: false, message: "Talla ya existe!" }

  def name=(name)
    write_attribute(:name, name.strip.downcase.titleize)
  end

end
