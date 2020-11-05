class ProductColor < ApplicationRecord
  belongs_to :product
  belongs_to :color

  has_many_attached :pictures

end
