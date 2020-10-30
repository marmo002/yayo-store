class Product < ApplicationRecord
  belongs_to :type
  belongs_to :brand
  belongs_to :brand_model, optional: true

  enum status: [:draft, :active, :inactive, :archived]
  enum gender: [:na, :unisex, :men, :women, :kids]

end
