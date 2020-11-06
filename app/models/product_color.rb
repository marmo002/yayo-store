class ProductColor < ApplicationRecord
  belongs_to :product
  belongs_to :color

  has_many :color_sizes
  has_many :sizes, through: :color_sizes

  accepts_nested_attributes_for :color_sizes, allow_destroy: true, reject_if: :all_blank

  has_many_attached :pictures

end
