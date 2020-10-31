class CreateBrandModels < ActiveRecord::Migration[6.0]
  def change
    create_table :brand_models do |t|
      t.string :name
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
