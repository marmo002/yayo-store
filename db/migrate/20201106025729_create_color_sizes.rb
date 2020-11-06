class CreateColorSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :color_sizes do |t|
      t.references :size, null: false, foreign_key: true
      t.references :product_color, null: false, foreign_key: true
      t.integer :stock

      t.timestamps
    end
  end
end
