class RemoveCategoryIdFromProductModels < ActiveRecord::Migration[7.0]
  def up
    remove_column :product_models, :category_id
  end
end
