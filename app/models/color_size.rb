class ColorSize < ApplicationRecord
  belongs_to :size
  belongs_to :product_color, touch: true
end
