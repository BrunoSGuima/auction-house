class CreateProductModels < ActiveRecord::Migration[7.0]
  def change
    create_table :product_models do |t|
      t.string :name
      t.string :description
      t.integer :weight
      t.integer :width
      t.integer :height
      t.integer :depth
      t.string :code
      t.string :category

      t.timestamps
    end
  end
end
