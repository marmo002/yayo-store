class ProductColor < ApplicationRecord
  belongs_to :product
  belongs_to :color

  has_many :color_sizes
  has_many :sizes, through: :color_sizes

  has_many_attached :pictures

end
