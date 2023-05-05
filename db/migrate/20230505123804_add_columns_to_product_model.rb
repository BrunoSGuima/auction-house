class AddColumnsToProductModel < ActiveRecord::Migration[7.0]
  def change
    add_column :product_models, :image_url, :string
  end
end
