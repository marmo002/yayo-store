class Color < ApplicationRecord

  has_many :product_colors, dependent: :destroy
  has_many :products, through: :product_colors

  validates :name,                  presence: { message: "Nombre no puede estar vacio" }
  validates :name, :hex,            uniqueness: { case_sensitive: false, message: "Marca ya existe!" }

  # SCOPES
  default_scope { order(name: :asc) }

  def name=(name)
    write_attribute(:name, name.strip.downcase.titleize)
  end

end
