class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :status, default: 0
      t.references :type, foreign_key: true
      t.references :brand, foreign_key: true
      t.references :brand_model, foreign_key: true
      t.integer :gender, default: 0
      t.text :description
      t.decimal :price
      t.decimal :sale_price

      t.timestamps
    end
  end
end
