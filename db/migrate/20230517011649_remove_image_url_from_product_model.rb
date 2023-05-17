class RemoveImageUrlFromProductModel < ActiveRecord::Migration[7.0]
  def change
    remove_column :product_models, :image_url, :string
  end
end
