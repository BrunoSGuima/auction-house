class RemoveFieldFromProductModel < ActiveRecord::Migration[7.0]
  def change
    remove_column :product_models, :category, :string
  end
end
