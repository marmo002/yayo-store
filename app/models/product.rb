class Product < ApplicationRecord

  belongs_to :type, optional: true
  belongs_to :brand, optional: true
  belongs_to :brand_model, optional: true

  enum status: [:borrador, :activo, :inactivo, :archivado]
  enum gender: [:no_applica, :unisex, :hombre, :mujere, :ninos]

  has_many :product_colors, dependent: :destroy
  has_many :colors, through: :product_colors
  accepts_nested_attributes_for :product_colors, allow_destroy: true, reject_if: :all_blank

  # Validations
  validates :type_id,     presence: { message: "Producto debe tener un tipo" }
  validates :brand_id,     presence: { message: "Producto debe tener una marca" }

  validates :price, numericality: { greater_than: 0, message: "Precio debe ser mayor a cero" }
  validates :sale_price, numericality: { greater_than: 0, allow_nil:true, message: "Precio de oferta debe ser mayor a cero" }

  # SCOPES
  default_scope { order(updated_at: :desc) }

  # temp method
  def status_class
    case self.status
    when "borrador" then "secondary"
    when "activo" then "primary"
    when "inactivo" then "warning"
    when "archivado" then "info"
    end
  end

  def type_name
    self.type.name
  end

  def brand_name
    self.brand.name
  end


end
